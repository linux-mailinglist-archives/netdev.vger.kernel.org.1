Return-Path: <netdev+bounces-294682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q9UGFDrnH2p1sAAAu9opvQ
	(envelope-from <netdev+bounces-294682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:35:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3E1635BEA
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:35:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=J3eX5XBU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294682-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294682-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED8723064640
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7675F40912A;
	Wed,  3 Jun 2026 08:24:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB153A3E78
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 08:24:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475092; cv=fail; b=rFpioWPnR2tZCUNU7EMaYxvdWse8sSZ61vG4v6NtYDftTxVzrAURCRYthhhgvpEWTHDu27wONw4fNz2SBqsv0G9oNfWzpgEj1ydXJTuXd7QqLXsQaaJm1I33zfqidyl6eHuzwgnNMGo6F5crsH/HtT2rnh1WYIfKHGuIXK6hMao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475092; c=relaxed/simple;
	bh=snjOYRs14C78sahndHuqrqp5WZ8xJEHznm+lC7EIpPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L21UNQqv3TVtNPnj7IJdYdF0xuCZNSEoim70SS3jzRYJZ8lBbASM4EemX37RFzN4QeN1txrOCEEEyabZWMNoowevOeXhgJHHwIIi2Yu7suCPu7JR/S3tFaV/HrPykwQKKdzEzrJHZeUQ/OOdkHhEjskQkCvtableMYDZIlgv5tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J3eX5XBU; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMfcWUuTqfgmC84N/3Wtnz90olTdBzwPnm3O6u7JNeWO27XVlDmphu7A12RGwJBeyjiPKn//XlJQQqwUtzwC+8VkYdXPDyhEwbxhps6yAN3VsK5zC52tFjwxkHUtiOwad2jeJ+eCS0k43+p8F42XDpRGuhJ5ZYuc6atcE106AO3VLwA4asyyAwBOtIuFcq/sQ3MfzwY/hMKwDSMFjgWjmbDzGgtNXiboaNifHSsuZer4CM6TlFHN6HvEoEN/+Phqgk14CGwANyqWGicLaNJGyg/uR3ouQbAIWIg4JYpzrfPqUe5g3hmFHNzdLWMpe+4SXrfdfdhr/bXCGfAQ6j7dwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIApvOT6ByTHie2Ajr8IPgK4Uqojq2qbesSJVR1iCBY=;
 b=C/CMONa0P4SmxUJFC7CXPo1px4PD7N2kftRcg8rQaAxDUMudcv+ziQiJxHWe4LneyurT409jMI97K8MEpsH4daeW9JeTEF9LHkKSvpcbpK5Yg+5miMchEK4hYdbYNH7UX/u1m0CX50wy3KvvaDIw9HT1JEqul3fx07XMw7tCHg2tG1L9pslINyzxLF/wx6YGjbHRHthrvOD4L7E01svcpluJ/3FnQyik0QedjFGyUYDcaENUzzj8W0kjTmTcxjy01Q7LyxRZB749bbuQItMq70yqr2u7TQpKQ+PQZPV1x6Ljc6IZ0z0MJ66dWYJebCtM39vw5bIJWf4Vo5kRAIUE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIApvOT6ByTHie2Ajr8IPgK4Uqojq2qbesSJVR1iCBY=;
 b=J3eX5XBUgQ3Nqs5xwlqK//K8dUPtnWFEpfYQuAWeT9Gona17MMIHBCg+ZSeFqyejOzvz841CGb+epn0YfoiMYKoNl3dB1l/q755QwqX7iO5AwvxGucilF1nQ91jx+R9kdIE6hZt9Xvqkg4momN9kzyaCd3Zmq+ejV7wrh6lbZ1DI0jKcfUwEFsKF/WCTazRCaBHkRahDAH1XwccHCFufC7Bf1GpU0LvIP1YXK5Yo3nRCmNXAdMWengJHikNGvICjB/e5WRHjWEl8JKgJx6hQZrPQEG5UgN42mT6AWrpuue/ew4msA2q8CTF+oKa49N9asaqImK7k1R3M5iOyewFehA==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:24:47 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 08:24:47 +0000
Date: Wed, 3 Jun 2026 11:24:38 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Tamir Shahar <tamirthesis@gmail.com>,
	Amit Klein <aksecurity@gmail.com>
Subject: Re: [PATCH v2 net] ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
Message-ID: <20260603082438.GA579145@shredder>
References: <20260602161547.2642155-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602161547.2642155-1-edumazet@google.com>
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 8857df69-b6c9-4161-127f-08dec1499308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099006|3023799007|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	zXCalIDrdHr/8lNJvQKAUX+AEkPh7UqF/GJC6vY90gdcpP+im5v2SKKUOYsRevMRfdmVXxrnyupoJ5MFmvjHUog5nI6kh9ab+iFklGjhGgzGcn2iTBqIAvJKEL9C72piWTkRBZXIAlOH7lyMwsoVSTA5wPIOOGUynlyaa4AWRi8GzRpFZojtivR7MU+1t5CG3Y1ClVDCPs8KfI3CE1l/BU70GUcw5VmVt74ZptRoHotxqwtuPCvk+hvE7OjlLklWKoKf4ChNhjs8u6P8LNJ/tInCL4/o3hpkixJI/WTMpQ86ysPe3VmiasPAe2GG7NfsVwyLwI1CwrKRci9NwtXB178FNPNjZ1HFg5igoih56HY57mBgwy5W5pwMxqOCZv/+HTQqSVEzjHLbWB9dnK0J2l53xr4RFaaKI6XCPjffZgYp0d6SHJp/MKLJovRtqNQJWbyMxat0L/qDfKK6wMjZGncWOrMJpMtufW6TqTCGfk3+gVT6/J/5pIAj6kiKYCFCcfH3yh9VzTKVhIN9YQIzM3UwY2pMbZtHX0ojT5ndLdYZixx2vaJhIuaOSwhKQcjMpr6q0HstNInN3ybSCK76nkVbnCqQog+c9go5i++85deSHHVW96ReDUwkP+1Efh9WZqzbdBgsU67sq37ar+Rs3pbxMFH/jZCIB533xLSk71p1M7LY+Bwp2ED2Pd/Yw/+1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099006)(3023799007)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XplNgQJZ5x0hUAXldHAF/SzRG+TAyF3vvnFfrKfWQzJ2S0m4nsNUxlahMhrE?=
 =?us-ascii?Q?ymQB2Lt5HrIhC5UnKK0FwzH9ZrK0ulwL8yg9TxvFmG6/b0XLavz3/vqmYDAn?=
 =?us-ascii?Q?fRbi8z9sXGNusBq6Lh8xlz5hm1WNEDYnr2OjMmhR0Cx2D/MNoAN0thLy/lgi?=
 =?us-ascii?Q?r6OZbD3Qiiejs3bS+ba70eg6FYkNEi4ta/jrCfIviFAGX7S181KMmvPY7AKK?=
 =?us-ascii?Q?/LTDOhZIzU5i6bt+Pz3Mjf18M/fdTq+bIhkXbBv1MWDejF6MV6yGu/77kBSF?=
 =?us-ascii?Q?oOj4LWKbRTwnS9TZ1Q1aThl+ttUQoYwSDoiObiooWA/ZqErJbhwBX2V5Jf3g?=
 =?us-ascii?Q?O0QCVLI/KXlMF7jWFtJfyhD4aKVUv1RFetUvskqtODYOyBFWpBNrATSoMBpp?=
 =?us-ascii?Q?4Po1MmskxZYyNM+xmhLS/DkKr8W20H1jGjXTPQ9cV4ay3c7PiETJS1Vc98Io?=
 =?us-ascii?Q?3OekgmegDEg/c3d5f/tyaeJFFT2k9qXf0sRsNSjMqVtrAC2hgshQp8FGrBoh?=
 =?us-ascii?Q?oRclcDOHhNfaqYEOxdYfLt0Bil6SEGYIfe9jXCyaoJFeTscYS7AcU2B5n5B7?=
 =?us-ascii?Q?lw95hyQ3OQDfWzoJEWicggzELRD58AZ4yemLz0zaQA74KPRB06CJfRM3orPJ?=
 =?us-ascii?Q?jRzDXz4ZM2yAzoOfr3PuvFz1vVjJUxUt9xc/lmQEN7nNUNg1AhGAFfnHAJ/4?=
 =?us-ascii?Q?Elx8/tCmthyoYRfPiMGA8iTAi20LeW06AuMpA8eaXn5CpmBpfsIcGxp7W2rI?=
 =?us-ascii?Q?VMiWOawhTfIFWcNbnmtpMrsTmBr5iZeKTCABRT1SXQeM1zODWD1a7WJymxd6?=
 =?us-ascii?Q?/CifoPvd3V92tyu1uT0qvYyW8uddGcwTpXILlkegvKzuKn0O7pA3yrRfVR/y?=
 =?us-ascii?Q?h95YiHXCwULBxtivjh9hDBb9AvmroNi2dNCmLrvCz1KAoVrIshJy3WBawfOT?=
 =?us-ascii?Q?4RlbDheifmTJzKc3I3TT14jRGXM0Of5PnWgcUC5ZYg1PMZrVqMpMy0ezswvY?=
 =?us-ascii?Q?iRdnheez2ygu4lbNg6oFBoPx6uqIg5DUfC4Uu88e44HU8nID2w9hZ8kjy0Yz?=
 =?us-ascii?Q?979L8qiRdD7HjKzO+pRzaRn33n3FgaEyrcQnOAVCrHUwriKhMYnD2jE5ZcVC?=
 =?us-ascii?Q?fj8NHZhdcDbjthxMHOpRflfBevfbI6Vyfel6ZzLZK4vtbONPy4qVsmqNgl6X?=
 =?us-ascii?Q?7C63DRLAtwt4pP9rh7yw9zuUyUzCC/ICD2pYeh5lhXS7jAYk174IGBg/Xk9H?=
 =?us-ascii?Q?pV3jVcbpqZa1Z+wsR2rJZNLekuG/cDb4klXjt7Qj6HQBD/4wStjS/Sx6iEMF?=
 =?us-ascii?Q?f5x73cvJju1qgx1c1+juFcMwDiR226GfgxqWCQ+dkLSe94SxKxnr8cOLr3h2?=
 =?us-ascii?Q?U5jDqCfwwJ338rrXR+p5HcQp4jVTy4wXL0iCvUl7zmv5A2PgK495JTZwx/9H?=
 =?us-ascii?Q?qHdu9cqSUw+3SzmcqgsBjeWx1vDXzTRLHkqsYTdKcq+HS5BXP4EnMkRYHy18?=
 =?us-ascii?Q?F+c0hm9yiYpz76Zqf/jHzZg5YkS/svTdCMiJblOHx2O8nV+CirzwrUvZSfqV?=
 =?us-ascii?Q?x4YyIimYDr9MNpbOhu8ppTSmYjJzwXyi6z8o5OcfIXuUz1pKyoAXXkPYCGGB?=
 =?us-ascii?Q?+rU2gaOjcQJ2hvbubl/SE1HbWsYno2XWVjPuE+R5kQJZZsmKZl+kmfkeqWH3?=
 =?us-ascii?Q?IDiQEN8LtxpChdd42pfMZksKmmQTPrC9fhomNvJQiYlWXkvw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8857df69-b6c9-4161-127f-08dec1499308
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:24:47.8067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsoX2gnTTenhn17fk1zy0lCQ4RlGYdXWLKByETMDtHYmXI7rh8GPzG9RnJiQ91YDhSXaXssIwpxS9+h/YBpnMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294682-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:tamirthesis@gmail.com,m:aksecurity@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A3E1635BEA

On Tue, Jun 02, 2026 at 04:15:47PM +0000, Eric Dumazet wrote:
> This patch restricts setting Loose Source and Record Route (LSRR)
> and Strict Source and Record Route (SSRR) IP options to users
> with CAP_NET_RAW capability.
> 
> This prevents unprivileged applications from forcing packets to route
> through attacker-controlled nodes to leak TCP ISN and possibly other
> protocol information.
> 
> While LSRR and SSRR are commonly filtered in many network environments,
> they may still be supported and forwarded along some network paths.
> 
> RFC 7126 (Recommendations on Filtering of IPv4 Packets Containing
> IPv4 Options) recommend to drop these options in 4.3 and 4.4.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Tamir Shahar <tamirthesis@gmail.com>
> Reported-by: Amit Klein <aksecurity@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

