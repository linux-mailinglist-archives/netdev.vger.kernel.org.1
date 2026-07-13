Return-Path: <netdev+bounces-307238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kSASAicMVWp8jQAAu9opvQ
	(envelope-from <netdev+bounces-307238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:02:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ABA74D620
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:02:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=m4ahdCyJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307238-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307238-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 062F53072A05
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E473E30E84F;
	Mon, 13 Jul 2026 15:58:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B230AAB8;
	Mon, 13 Jul 2026 15:58:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958302; cv=fail; b=W6MXYs025ji/Cp6qSBNorHHZPXeX4hWAodizFFkq4qOa1gJ7ufwnHGcNs+F8QSUCtOzVHUjCPPfdj+psxPnTOePSX2oz4zLw0hzyEGgnoLEbdq+ByXr9UTZJh0EOiFDOjLRRRzSK9YaFQVX5QgwPDSw48PL8ykHjzfy84GVuq2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958302; c=relaxed/simple;
	bh=aNSFmFKuF8i4FOL1DxkPToAHITQ2Lsng5KxNdBZXBrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iGRl634ZsFlRIKqipTm9rUqaYR93dE32/AjoYDDsVumwx6Z0J4/ng1TPjTXVW3cBeaG0Vse/p93AQ6kehX3BG1ZgFZqHM+E46zC7FxiK3cKgVqcP3L45xL17v4vT5jGFJML8s6rcPNzIE97s8y3z7OD3rKk28/4xkGbh7EVTwUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m4ahdCyJ; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACCKzYndACBWJC7VZJI8KKp2HHLInCN+/Rp7h1DZo8xrFjTmoZffsFuCo8XKXDt8iMmO7ZBmLWse4XcA1apPG2y771m4oJdK6YxaCwl+vSI1evoU7YhUv7qd6t8o9O4S+zWni5CueJgWwVdGK7sDXU2VfCHdI6Q0oZ66rxajX8h/jWnNCsKEOj1yAOM5mKP4YOYaUC1IajSiBuVUjZ0Pl4LNMCLUDUNFA42zX51Vp2BXwozYR1xkpVRmHy+YkGUkJ8lihz8Zp0BJSxuGcskz+/9HhQ2l4kp7oXQ69cgSX7yUuQ+LJuwnJrZF24vhFMAF8FiNXkviioTzB3s8pHbAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJGcx2H7JXYIVltPOCUxWooisRBN8NB1oYYMPBXcKu0=;
 b=LZ/sTdp72RJQAyFjBIoiC9OS8ojd6ak9lfBreayXFXcgJsQKfunugO3FpkkDoqSmkyDjbFNAcIYHLupZNC4q+B0IDV5xVcnoiGDw/CCqr3JhfMbN4CFpjZ1WJ1jEHlG55LXpRYCPCILgPFAIrjaAI97dV4puHWAPM37RLOuVXek9AJYg5RBizCGUFAmkW8kFWD8+sTdiQK/HGZijDLKEMvZqYDjQXPK4Dwqsgnb5mxnL1hmn/0GBXqfrHy/s1vixH9niTTLwvP6gb3MRpCk7Popqb/7F85hykbpnKsQ8XuML5bRb73631QkfBFlHZTGsxIIlXrK5WJwIpBY+piZn7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJGcx2H7JXYIVltPOCUxWooisRBN8NB1oYYMPBXcKu0=;
 b=m4ahdCyJdeaPFyM5rjqPsus997V3+LWCqjtTW/p3mPh2/16FU55ff38tyazE8V+9jAJ76xmOGOaWJOBaH5MM1PaLE4rreKD0TyP1nLJ6QrLCmrT9+V4FaPkAvgg7GlankwDH04RK744jm8ydd2BNvJD+bqUO5hPzaXuuAPezv3UcpESnvmBl5ppRsrzF4KE3EuvztV+waGJl/a1niTKBMUSsnL3u0/XrAHoqCjsf2/2Z3j3dGa2Ui5rYzPA/0X/qU1dqC9ZCwkMQnx/7oR7Xu8Tolgf5mRMvXux5FhdyIJW+XxTKrlWjpeAuTWjFk/ZYYUyaj9NfH3iEwDrL+D9ETg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 15:58:18 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 15:58:18 +0000
Date: Mon, 13 Jul 2026 18:58:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: xuanqiang.luo@linux.dev
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net-next v3 1/2] ipv4: use rcu_assign_pointer() in
 rt_flush_dev()
Message-ID: <20260713155808.GA656327@shredder>
References: <20260708060537.17188-1-xuanqiang.luo@linux.dev>
 <20260708060537.17188-2-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708060537.17188-2-xuanqiang.luo@linux.dev>
X-ClientProxiedBy: FR4P281CA0309.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a67f10-8cf8-4a0a-2798-08dee0f78e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	wJTyGBfRLQs02WY0DYB/v7zMJ7JdBAzFulKEB7777uuEuab40/ttUrcqWqkM7KBCSK6dLXdCvPnC0cMbNjLnnL7JLj1uHYqyMuBHhpY3SkdtBWyyx0ENLLq/omlOeyzZTpz9LPb102mbssrSCySZ2TNjq4k/mJ1AF0mPpwDOfBC3Mx+ZA3sLgcpAbKgt5AYhNSHfIwesvS0V88tQ0ZU/8SU+19xjV8dR1wUPGztZs5muBsyEvAT8zscCDMv/C4q5yCX1wjYVN+yqPiaPuXq1vbdlM5sJwH++H/HSqviLn7D/oVy66eOSUhDhE7ZWAbBfroUiK/k8hs3PllFTx/r3q2E65HNBZqAcTk1ROzutVz9BBwGcTfyRgsJRBldbwkmY8epCAo7ECVVZtiB/ptoKj0SPC+soiX8pyCNYlQMhZoI9IbLwofhij2H57W5T5Xo7kzKtcudzoX4I7/AYvbAP2QzG7OLlGcr4vPVqsXh4g8V8WuWg+8d1t9MsS2Y9TD0eg7LIhcWqVTmGl857v3Q6/q7lTGXBqO7CVeFR4DIQPVDjO6cK4w9MlAVXV+bg75PiK0TvpGptI8h+J+lK7jZpH1dDmKQYAkm6BW+jJPh/y811zCbPH2YUK4cu3WArtes3Ajynb9cCWVmD+Ta8DKcg0++RwZHgRg1WpRy+/0vtDnc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PeqYEeDxPvCBhydqtIBtV6PBeQEHI7KKNq7EKs058Q1iTjIbljhjrkW9WSG8?=
 =?us-ascii?Q?Fr1RqmiHQt8a4EFJHEYPJAjFgA9GDXJ79TPfmxmjbh280OS4OIgJ0vqFMxvF?=
 =?us-ascii?Q?u1M7GWEdroT5ND+yyQ0fI6kndzvUJyZJScRYCt1clsIoiplRQXx0ag12kCX1?=
 =?us-ascii?Q?VJkOBMB0IT6caXogaug1LjFnfurCtt53Jzr20swxjO9LCj220BAdPIT1Ve13?=
 =?us-ascii?Q?bM+v4FLumDQGKc+GT4Iyr8lFwB5pKTeB7PfVuCiVsjZFBtChY9G2kZa8A5H+?=
 =?us-ascii?Q?PEBfly8CrfHf7TNhQQGAJfzx9HAMCWzJpNtpdpkilZ3dnsOMupPpeKB4aItv?=
 =?us-ascii?Q?Bc7Toh1xGu3ghSNo3xqZ2fEqZMSLD9WbPBTyKefG3cbgkt2H0HVka9r2IMbD?=
 =?us-ascii?Q?Uop4BJCE31fVvSwzO6TzBfuJwY/+P3ZDbMUBhn+z6QUlEGlDK0sP/y7A5VR8?=
 =?us-ascii?Q?od+kAwwhGzMCAXmCjhz4KhVVAyLJk2Nlm8NRF/+DydwzNHerBy+q0c/FqP7m?=
 =?us-ascii?Q?MBvQFMvwsbo0SM1pyy32Ux7zY/d1bzAPiBV9KpZ1wNjdJvcSXUcLPsZ0xvbI?=
 =?us-ascii?Q?I9W0T8uy7yJrceZPolRjblyiYI2q+nJ4Sn9wvBRHk0Uk5putz37Mbhs/zwGL?=
 =?us-ascii?Q?L2H2ePcCHApMhjx7glcohdsRLCQ8VWCk4qEwF6an0pIdRaRquJ9Xb+tQVDye?=
 =?us-ascii?Q?Gnh+jOcK9KIEDIfHnCddt8RiRwRKVnUE5y5wPngxQ9Ct+6oFh+JNWPlP//g6?=
 =?us-ascii?Q?jQhZsFbSu0V9j2vlvqdcPWjkyva+I/V5jGFDuPl2zTjoEaLGHgum8JOt8cbq?=
 =?us-ascii?Q?SvIUgdvhU6Zjd5uTIQRGfHx+fSY7zOZnt9EXFOwEFZVLUuycdATHMDek3hIb?=
 =?us-ascii?Q?qsjpP5ctIH58FwktMEEF9xn32JszKHJ4BAQldEe7PfGfuauwlfKWC5skH6k8?=
 =?us-ascii?Q?Z9sW0k09jnut4CUMpe4NUGYksisMDgwEN90zycnhCwk/papuPESZ7Oifgd7T?=
 =?us-ascii?Q?ac9Jiqh5AVPpwfp2PfOpBP7hoP6kq0ReEAkthVVnyXdwGYnXny6zZhIErimp?=
 =?us-ascii?Q?WJC4BJO1llfZdmNuILSlDg7MzyelDhZJG5ejppjAU5NpUWtmwe5bKkapIiY7?=
 =?us-ascii?Q?j0kzHRRRukoBOhEYFOYITurGlcIdF+HkgvZI37C/KecWRZLYrPwPshYxfZGT?=
 =?us-ascii?Q?YTsvH9OMkFkmLvYdBqjcZH2t3+xpC4tSjglzVTscBKxpYfFJjrvnHnU3m1IJ?=
 =?us-ascii?Q?vPdNAzNvljKBWeIMFCNFSlRRUS/iCfrOP3BW1H5GhE9pQaTe5fTw2Jzvu+MU?=
 =?us-ascii?Q?1Oh94s6T7imNqBivQ+PgiqCK94dbB59WUJPd8FFiUgELEWl0K8pgYt4K1drL?=
 =?us-ascii?Q?DpJN7SwoVDc4xeM3zNWmtmKr5YS06DxfQ3D3FnEQSu9qsKagIppUL2fiUeV9?=
 =?us-ascii?Q?MIdTVPBX7Immac1OOLvGOeQrxMaKu5MgjBCz8QWdjd85nbFrdtHZ9flDEvVz?=
 =?us-ascii?Q?SzA6mZYUL4us2wYIKG4Fw21G3He3ujiBUkvBqw4+KxJ4+qb5HEss+XGuLKcv?=
 =?us-ascii?Q?96qHjqIE4MzrM0QNidKxQfnbHaEkCeEftKsxtwgiK+9H6sKi9Rx0OKNViiH6?=
 =?us-ascii?Q?dNkNbn+Vh0zb0cuVHaaSG5oAj9S/RaHkbe0KGooW/mQUHbpuseQqIpq8O2N1?=
 =?us-ascii?Q?RS+213S7PstiXXdgO4US/I0S8pDzQpR91mTiei4XHxDjmXV7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a67f10-8cf8-4a0a-2798-08dee0f78e06
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 15:58:18.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1yRgP73gis7nGVD5f4qcx5QULCt0Hx4eQNCbVKDk0vqbFIVPT31+weo5WjEn3cr+YKxpEgG4s1Iq9epRCfJ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307238-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:xuanqiang.luo@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luoxuanqiang@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7ABA74D620

On Wed, Jul 08, 2026 at 02:05:36PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> rt_flush_dev() replaces rt->dst.dev with blackhole_netdev on uncached
> routes.  The field is also exposed as dst.dev_rcu, and existing readers
> use dst_dev_rcu().
> 
> Use rcu_assign_pointer() for the replacement, as dst_dev_put() already
> does for the same field.
> 
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

