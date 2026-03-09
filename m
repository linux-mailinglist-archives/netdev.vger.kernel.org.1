Return-Path: <netdev+bounces-265552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLl6IQrJrmlwIwIAu9opvQ
	(envelope-from <netdev+bounces-265552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:20:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAC1239992
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2F94303EEB6
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC223C1976;
	Mon,  9 Mar 2026 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tyKgPo1q"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D223C1992;
	Mon,  9 Mar 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062354; cv=fail; b=QVNpJgN+GMU5KpD4WBKpTQABcc2PwsQ4Nk7wTtbs71SDA91V0X1IEmu6Y++1mi1/y9d/BnAIo3lnY+vuFZ18+T/UUB7/9jbE38Q+k4+8Ygpu6Irxkl81M5ISKaD1RaePDcpxInRPAltwhDfHr9NPgX6Qn5eYIYIV4l+i1e3F+no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062354; c=relaxed/simple;
	bh=s4TaIvYSMIOBnQDwUuPTF+MFQnyP0YsRztD//KEtetA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zqcdz/J81XbfZuehq85e0q8gWxeTSEZmwn2I7NnX8mMi61PcnRIabbl/jpSXSjp64W/9gPzHNQeXEUS/haJHxPig5AAGBip7s43u7DMuSfZsHB13mJC0z6mdCH12QwNaqQb3b5la4JOV1OSWLtDf3rUPiBPyVzl5890C17lW0kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tyKgPo1q reason="signature verification failed"; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p58TZ9gtGWGbzsPJkHbOiHadEb3rPU+MdvcBNBIi9DVZ3JyL3DMlswf/mni8wJL2JO/HmqK7K+3f4RMSBFIco7c5Yx3GZPvx8E0+ikkK5hVefvpCsdpllT+G5HBQZN1UrSJ9NRqDWywIOVGjHdRUwz0Vsk/4/Dnny8/IzA1N6sM6auFAO2ujIH9EF9AH5NLlD4CZeMGvpD2sZYeKKGyt/Vqdo0qFyobWQMOHxjH3zIkU98BD/ccMolJDYYvAueB9wrcLpdMYEwkEMdee8tQn4fLXVjDbTBcC6+Vq8caYlnoq1mPR2B2wpxUrxX/R+wgVQv0Q1qvQQddc1vn9DDFFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmTL7y0+wzJjRDkyaWMwDMm+MbnGKQOFa06xC2lH0sM=;
 b=eow/X4WpAueKD0EkW3d7hZQ5tAMk3XpWFt/ow8lJaZlXY5xtyzmOT0Yv+zTarijD6zUaqXR3w+89MLpEHdq1LrazNjCA6hqS+Woo/075b0BZ134xs+poI1lF7YFDcV8Q5NCzR5Gu+zUfGu/aPLIddgY2yJ12qdXDxqfGXECedyF6RYTX7J6XiCvY6LMHiiyiZZS/Zu6xNvFELOprlBdRUTlf0iMFor4QxD7khUQbfRXUCLJOpIZNtQSFDru6CWD2LWs8cbXhI+0IDRY2PSposFYNA5ZJV4/DPWp/WeB5u9Kf503KFLZ1OYh+J8BMrxmt5r9NFMapXn4OLMEg56jELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmTL7y0+wzJjRDkyaWMwDMm+MbnGKQOFa06xC2lH0sM=;
 b=tyKgPo1qOjwxaKUMVi+Pwmf5A62JEMEBwXjFGk+CdYvLSUfV5qgKQ2guGe/j4nIIVSVTYhlcOMPPAjIZZgppzjbt+MNbpcTX3kec/9oSjTi4nE3/XHwH4z1D2hLhL+IVRlf+1wajvSe7otzLZ4WxLIwJlk34WpxVDhQ0Pg0R/HHZ4RjoPzS80wE6wbSlYxP+Dgg8+NIb1Llr8qw7BUVdo0PAGNV0vlBL7KjKjGh4tqbiMO8MjWkyZ0EDRP9fVAHvHm0tSBwMx1AKPLaDfgYuDsirP6nhfJp0B/l1KMpxhzLn2t0Qtx+zxsf+4zgEmnJZZ0X2unH8iQsUfD7s1uZbBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 13:19:07 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Mon, 9 Mar 2026
 13:19:07 +0000
Date: Mon, 9 Mar 2026 15:18:57 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>, shuah@kernel.org,
	petrm@nvidia.com
Subject: Re: [PATCH net-next v4 07/14] net: bridge: mcast: track active
 state, own MLD querier disappearance
Message-ID: <20260309131857.GA1942372@shredder>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
 <20260307044548.5230-8-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307044548.5230-8-linus.luessing@c0d3.blue>
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d57efc2-d608-43f0-3366-08de7dde7134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	RbdYVTQme5J+wOgI5u7TD5hGtujGgggaP9x9XbQZQoczKfaqs/qfMoMFyOD/aOqzd76DPAYuS5Muem3P0UX3xzmwLoMhx64Du/uWGzmFprXH8g7vr6m+Uxlcmqj4fPO5WvC7gZKrLCjbWakMN9IlTqBBlfWQY7XNKp2ket4Ri47zNLoq096gWxM+rdVjcwXqwapTIAfO530J3xEnQ27SfmB2JJsJP7uxevqj3m1gAz3z59UJxK/wyTcwaaTbO1s1sxBdji/ddZmGb1ikmR3PAwnELQgPN4vESn94r3yXQ4L5tzfg9rB39KoESJBZAeqeK5QjVkQPAKP6FqQ2xMbINPRjoBt83uLvFHOhQl19MB9fftjHcmJcsPZ3lb9Z0OOQ7w6oZ6egLUB6X2v69i9JBCMs5WfThwPrshv7eADOAOI2uCL34CE6df+RalltvkvejJFhFd4YgUxCRUcZWohgcJ7LUXBagTQCxXZBPiXXmrFd5NOWMBpq/373LMONJzifdmmhln+96oz6kSEMp55X+f0Z3DUWbe7GTHiuiW++5FdzYlVpJoXuk4Ms4NCinkmCk5wk6KRPFgfeCSJzwJMh0g0ZWAITgK1vucNvaR1V2lSh3+mWCbCuqG70GaHgXrq0nlF+kWExgmDNiN+h6GwfYGhGuPsXDS8gm54yFcA15HKjYd5GVWssKYQV2SxsZB5XymUcG44uijorooqna2GqJmmkgE/GtVhnjRuEQn/IIjM9vlk3T6ZP9+BPKmn2HLks
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Ve7Z2jwB7KkCh7naHHSH7XChF9hKcGpTqWFgh2iWb0F+yIZQdrh8kCPIbJ?=
 =?iso-8859-1?Q?srkttVCQqKGs0pKh/Ppu1mu7P+NUpjfYvq7Cu9tpFuMVt2koFtOKaUoewV?=
 =?iso-8859-1?Q?qUVfidrtlvO40Qs85gkfvAxBGtO7w2Mom9T0NJ8FkeQWEYHKrAh0rBtH1F?=
 =?iso-8859-1?Q?2B894SY7u7e49cEsZy0L/6trsQ09+KajuXY+u08tt5C3VKS0Afvc7r10BA?=
 =?iso-8859-1?Q?vLYBRw9hE9AZuiB5hevqOn3dGmXMPyo1XH2JwrwD5g3PZKyjo2UQ2NpWHP?=
 =?iso-8859-1?Q?ZdQ0JShxRzoqkrMZQ1Kcjnq+XnZkgqPArHzPjElTVOCXfuE3CUNDYRwG52?=
 =?iso-8859-1?Q?uvxFkDOFpzIwjEfPqYnuLGGrazrZzdarIV1dfLNA++NPWR71FcD1l7nF8E?=
 =?iso-8859-1?Q?AAN6UJiryFwUYBnEtHeUtPFC15s46GWXG2k9d34+ONAFZdAPTqTC6aBAdq?=
 =?iso-8859-1?Q?vPYoEylm3oluZ15DPyZZzoUD+53xVqFayGsHigUOjnmZIHZBMF+TtK02Ax?=
 =?iso-8859-1?Q?t9LoI0ZPNqJZ/Uu8eScNhUusiARXFqXM6PMr4uX4juZB+xg3vhr0KLNilE?=
 =?iso-8859-1?Q?p+7ts8YQWZagUjsMHbqGmU5xLQNCjeyIwnNkFiqvV1vZCyNcwyyzog2KjZ?=
 =?iso-8859-1?Q?q0OVXrq+90Q8UezEOkC3Edh7ypXcdJXXTn3NG2BUeb0Vxrw8cWhisyY8vg?=
 =?iso-8859-1?Q?0keBPHxQS5cxjYlVE9bDpcVGmuZBUdfuXuWb+YSVGiX737aCNFooKtZr0Q?=
 =?iso-8859-1?Q?b7ywGpA/+697dzW+5iHl4BjWQthatpSFe1nccN57ciUkt4OT7V/2VjmQnV?=
 =?iso-8859-1?Q?6iHA158u2VeBOJe0L70EaAM4rXBX1Y5NehB9Pey9KyjErZQHGY8z+67tRX?=
 =?iso-8859-1?Q?6cDY2IaXDr8eJx9Wn7M6FOXoVM1bxC8UyS6ot5AEcAuv4KjG7mmvRLbL/7?=
 =?iso-8859-1?Q?mviQb7UKU8JQpOee9r1R0iCIKyp88ub9rhnPMQ2fKddsJFHrdpyzoJm1vf?=
 =?iso-8859-1?Q?XLByG1wyokXk/T0lw7CwUECllPBmZCdeCX+dzGE426tvCic2sYCNQMwWs0?=
 =?iso-8859-1?Q?jPN4OadSLNFSVyN9OxQTUxnRbkiAGI6UGiJiHBT049k89R8gQe072Z5A/F?=
 =?iso-8859-1?Q?UckEijB/9iNDI9YCsC8jgHbACHgfD/7XAUjoNG1lEDGIkyFNc/9DRWmYok?=
 =?iso-8859-1?Q?IzTlBI79UjmEslT68ki6XpRMLS89uR9w12j6DsuPFVE6kLGvxXzj1MekLt?=
 =?iso-8859-1?Q?W4emSuNlA2pr7PMX5ue1sWdsYNskPHzIsF6prwzyX3/9ibV3h2dm3RjKDj?=
 =?iso-8859-1?Q?d0zxRzASNkrzs7yoQp1q3AoTFXXAWmAT4eSXFX8+kavbPRkDf23tadpaAW?=
 =?iso-8859-1?Q?t98fTqnBMI4yeuKGzhHLr45ip9ez4gidKYyWK5GqXmaPlOkNf/0JHHgc+k?=
 =?iso-8859-1?Q?I7AsuiWWa7cszblBIK7779iABcubtwXbJkMTwOyw5ElbEl69pTGq2EcQ3r?=
 =?iso-8859-1?Q?kYMJz3BGljK6Kpt8/ZhLIG7jGThAO5jp9DMfPFWyriLKkYdhbCpPM2M8z7?=
 =?iso-8859-1?Q?TeI3CwRwWKHqMOKHd79/nTeClY+7moXAuE1j6LhxqPbOI8JZHLDnwiGhzC?=
 =?iso-8859-1?Q?wOVtOKILv1ebkV3S4W9kh6xBSlUtPXWsrWrDjrwaLf8v0Ag+yIhMQeRW2b?=
 =?iso-8859-1?Q?+Cr0NHPskCPrSAM8jl+mNFkNImuGsd2gmWUTiDdDCZDiG3qtjvhFAJTtBp?=
 =?iso-8859-1?Q?a1M+zFQTK3sjFAjYXbZZ38CsKDfhA2JFFrfaVdgyPj7qbcCbbYz2Bi8xNN?=
 =?iso-8859-1?Q?rwQC5k5aHQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d57efc2-d608-43f0-3366-08de7dde7134
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 13:19:07.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSXliVVgib1Ge4FXwRY2uWGpch4tKFqsJ5hyePkNV5p210+ZZyd/tHqNOk29u1X+DT+H8W8eHVm6qaKGm+uI+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827
X-Rspamd-Queue-Id: 0AAC1239992
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-265552-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.406];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,c0d3.blue:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 05:45:41AM +0100, Linus Lüssing wrote:
> This change ensures that the new multicast active state variable is
> immediately unset if our internal IGMP/MLD querier was elected and
> now disabled.
> 
> If no IGMP/MLD querier exists on the link then we can't reliably receive
> IGMP/MLD reports and in turn can't ensure the completeness of our MDB
> anymore either.
> 
> No functional change for the fast/data path yet.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Please take care of the comment I left last time regarding the subject:

https://lore.kernel.org/netdev/20260208160907.GG154003@shredder/

