Return-Path: <netdev+bounces-262653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H8iMzuSpWmoDgYAu9opvQ
	(envelope-from <netdev+bounces-262653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:35:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0381D9E30
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C34330106A5
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 13:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3123E559E;
	Mon,  2 Mar 2026 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yk0nVkaT"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491FA3E556D;
	Mon,  2 Mar 2026 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457822; cv=fail; b=RuVJ8lMzgOdNxwAKLAWKbPH0a1ALa2nv6vbB+zI5eKSGuufPc+eRqJVRvyIbLkQVEw3K/v5f0qflxuT4FacPsGbOeGvj4xkIx9cullFq39w0b4JAJOVTamGcEQ4ZJlz02pQhtJlcUd9/wVAqNt1niv40ApbQ6f+fzLmEaaG1pa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457822; c=relaxed/simple;
	bh=K7A7G0q3gvDH9+/wAomF01utQd5cApDQSHawkKBP+/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VdES16xhuASI/eO2uwWXu7/WNPrkq5EAJP64LSOkuHgDXfx6UMGfuiq7GZvhUq3iGBqpkP/StF5xtPnCSynmciu4nn09985oMMkULXnRpZXWzp3+4dTKCFfOlJQG8ONnDLghwNZzAF/rc+Uc1Cdyu9QH/T0oJvAnWMvvwD8NuSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yk0nVkaT reason="signature verification failed"; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pifFoN19hQPy4dZGQeXH3eQEf9s3JTvfJjWTK06aUtn334PJGvye1X0jhbp6D0Ydxf0iEJHN7lChGJDIbuy66LCwYRPh/tB97R8k5cXcia1oFgHSbMwwvo77OLPiHICMEKHbDkT6d1mc1uuu3ligCiHB0z336sGJT+DJwWABp0UI+8UKyDEsBPE0QmrjyQpU2kYCc/QPj7QPoIzaXGBHbhhaH27OfGfTRGp6YFM8vLXjuUOkz5sPcnb+gnKKbJqySoaW3T99s+PUi4ZSEYoaV8ww+fRGDqrLgCJ4QrtFq4PY1tYhJaXbEz9C3wqCSX/PWdXC640zgWz7G3+J8Xo4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INdwwSQfYRoeMbvwJowW4Ay04wZdLJiHeNKhHxSnB+4=;
 b=Sthwq//KllKxAMn1HzQqnGNr/9qF4jREMIap4avO8CtYPxGwr8gNx1DQP5inn6IvMQ/RlbQx+dltdjOPHKxEwqZ7VZmpYRas8ck/KBz6Pyjvb4/+G29z6R6BlpVun5z5kni5vpxcBuORVzXpZIQbcFp5xpKD3lR999cAJaY0mAoy/pxYutwemVNwnT/FIws9gWvsdvbqn28sFuLFXPa47vK1omttJwTsMzuIfpowuA5jbk/85WIvdw13x2cVfLbyN3tL5YSwotJin8MxR4brUsCXpCRqO1leR0TsCTw4kVwTtJVq0YY2jcbnaIvxPbqT0CiMDgBRoBHzSrln3bSZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INdwwSQfYRoeMbvwJowW4Ay04wZdLJiHeNKhHxSnB+4=;
 b=Yk0nVkaT1vn2Ly230H4RPqY0rURx2EvKqOiLdVYhJ//baHJb68oWH6N/B9l7gCKcALmG0BK20Czh1F+c341FAWxZ9mdbPudLWjLjEhTCstff+xX73RZYT87Y0edjvlZC1VLJi1K7XDT+pccjJEqKFB8Wdqxmon2DQUW4fSnvJnvwogGxh0JLyx1H275qDs23/JkAX4paXqCwADQOry85hnjPQ1ZUYf8AhTY0FWdpCa2x0EfPNZHcP3iJgYx4Pd2xqqMRTKBq1yc6FVRrCtE0PrvzhXckdinXkvRVBGb+NjHrl6u3dpeU7c7AAzEta6SOXcS+JFr9su7KnuN8qylWJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 13:23:35 +0000
Received: from DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd]) by DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 13:23:34 +0000
Date: Mon, 2 Mar 2026 15:23:29 +0200
From: Nikolay Aleksandrov <nikolay@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>, shuah@kernel.org
Subject: Re: [PATCH net-next v3 14/14] net: bridge: mcast: add inactive state
 assertions
Message-ID: <aaWPUbG3_X4s8T0R@penguin>
References: <20260302054008.21638-1-linus.luessing@c0d3.blue>
 <20260302054008.21638-15-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302054008.21638-15-linus.luessing@c0d3.blue>
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7928:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5ec57b-6546-4632-0d97-08de785ee7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	BFpQ1jdHFWJrzBjjGa4McyiNrK9NzoGJ3xcaBp76uEw7aYzFnOGaeqZ3hBywZ3GBauUIjwjkI/I2K0feLx6T2Tq1yZVxqu75t8udjUOW1aE39Q3WNBkCUm/iCFW2bQj95lrpR3wVkILxmHEMDmMTaGwb7bDAbFmjdmykK/k+bzBNjJ1OA932gpgRhZjOCAu2zUiuO8VZ4TNACf3i2SBeLFpYsLXZqnNLb0xB01+U8lTy4QZ6VhYoGolm467gSu3+7qjSy1/oBYKTzkhL8h+09dk2Uma7gAwEaoOwb9qIj3SrjdD1ldLe5GnWtYz5uFAwpYaMZjkHsFhsI2flrKsZczDL385V2Ud4O2pdqroQkjEakJhmbeLP9GnjlVVvGC7e5qcbPQZNH4ncE/zc/kxC+TG6h6VK9cLbFw409KLzcnmWnpMyndmArHWVDrtmcRvs7YC5q8xhQG483r90K7NgJmtBuLzkX5MnWGYHus3SxQT5l6nDfFTXxBlUPhHLP9Fz8BfSsWNeKfloZrjfGsz0zq3wj6ktW0azDzAdZvXlASwkZdaqRRx6vT/VAqOBwcHvgpzuiGBmjEXeApkqkX2DnNC2vJjDq4rZxb2Zd2GTA/TxLiemDWytwRT8Ny2oYhMNkyO4Y88Lcx4PcbR3Q+xp9T2cnF28zzcAMNCg+MLfDRZiS4MdiAgmCPLZmqxGmj4vF/2LSIEoKZugjQaqfqjB6Bd9YILvzpSdyfHtosk7v1U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7928.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?nLYjh++9QUSBkfrJZX0fGhT6STc93rF+HZSEcVf41fYLTTIb7Y78SX0jY7?=
 =?iso-8859-1?Q?BAXMRXcEoN+EeLjOlFupkx1B1aKckGWsjkYK5H+zN4kNTheomGTvp8hwI9?=
 =?iso-8859-1?Q?fzoZmrg2nAFP6f6GudJULjWw6zQeJXSy2q8p6UNMOF9GsCebF6xEnhQKlR?=
 =?iso-8859-1?Q?laCOf8hqoNWg3bdmgn+L+ZrWup5VRgb5XFj5kPUmq5lvjpDSWeStOFkRXF?=
 =?iso-8859-1?Q?w2cx6Yp079wIUR7wFYmNhzK5H1vV4JUudDDa2XVdqjlyoHx2bDsrmsrE9G?=
 =?iso-8859-1?Q?IY6zm3MmfMWHX2FoqWLAW3CKH8RBeDuj9CNZitZzta35uQH2g2hRCXa/Oi?=
 =?iso-8859-1?Q?hQ7eJ3xYqTpd1ue408ssXgaUkllC2Y3q+p4EAo40ZqajFq6TdDmGUwECqo?=
 =?iso-8859-1?Q?YrQZzuVy9N4hNM3inuENaNkgWd0jJu/ZeDNgGlumQbZ2rgPiTagB20hQys?=
 =?iso-8859-1?Q?pT+uzH2GyA1b+5l0rg8H0JvY5uIpGcvoDMwUYnV5gr0ycaZnZ4zbs8nY31?=
 =?iso-8859-1?Q?9nCxMFW1Un9Emd1QJ832p2WRU8MIpXF6OaRBnn0g0EaVsZw+0eFndN9muW?=
 =?iso-8859-1?Q?zkewxf1cpln7XJ3dZRhOVYg9IyE9ghDefVUql0DDfzoA5COyiUR/xKvNoH?=
 =?iso-8859-1?Q?JSlP727ODRBelL/o8fWu1ELPIXSA7wAk0tauInQvXM0xq7kywcU9/kNWNs?=
 =?iso-8859-1?Q?IQCEBfMEc6ycKms4Y9EMtINQWO4fkP0jEIqHKy05qDw5+au5zSoBwYnoVY?=
 =?iso-8859-1?Q?iz+/obpBp79bmeEHWFdpv+2t8Z1VFYzvKQea45X+rPwth7WDukziXSuMEc?=
 =?iso-8859-1?Q?F4KC9O0NSBhzGUQjpgR4+0G9tk198zkmxIbtpPwJGt8yoKMAoewpsPmjNx?=
 =?iso-8859-1?Q?Fj2e4F64vaqflkkvW3bw9NFvPISToRUqE4VRIXI0sGyl08JlpITroQiRxE?=
 =?iso-8859-1?Q?mWCGrJJdpUkfjhqt4tLuEwUWOUJzUHVnRA1QL74VwKJuGgUoj6UgKBkcKe?=
 =?iso-8859-1?Q?UvGtV5uSmF419AK3YPUFcYu9V99jvn45OFVCs0gSdKJKfmNflF9lGxYzlN?=
 =?iso-8859-1?Q?1mgugEExY0aFMlrE2LkJDcdAMDNMch9VE2JUelaO15/AHmLZlS35M8D9AN?=
 =?iso-8859-1?Q?ZLUaPUJBvq2YWur8oiq9DGlmd27WTf9CgnqiAbErLhKqnKhPr+66JioGkM?=
 =?iso-8859-1?Q?TyOCUZ0Rk9c0QqoDOlpFgB0Opzc9o+j5UIAQIF5Q//JPjmVAoFmavva3Iq?=
 =?iso-8859-1?Q?lwCw1Nleeat+nWo38WSUPzzkCLgTesqNi/wKdI5AOWD0Yk3qJ8AUz8hIHm?=
 =?iso-8859-1?Q?4PbZmWd4TaZfzk4RO7xDkNF5e4cuPQUCmIjMYXzdt+xXL7IqyzNk1bv5+H?=
 =?iso-8859-1?Q?ilwSq6L9DrPgoMOhCZUmFKaAAEbXTwbSqiNmeNDUFbAGFMkqun93zZSrPW?=
 =?iso-8859-1?Q?lfzX68ZnLPyNANgUnFd25LekJFgdapsNxot74a2KeGzro0uXJTAQX/O6m4?=
 =?iso-8859-1?Q?lrSMYes63KM0FOThegDuCnobMqs5R42CtCthmg3OWfD/O7Kr3dDv1eEOeW?=
 =?iso-8859-1?Q?LGp+FtbV9RJoPewkaMOHl52FyRLfB9qV5w16KLygSHKkJSygkd6/FBAmkK?=
 =?iso-8859-1?Q?BgUwBZ1lxlWsQRrZjURFTvAcpTGvsLQ1bP7K+YETGfpLGVsccqGZRfMI9O?=
 =?iso-8859-1?Q?L2y2fkXg1nXxsQAjh6sQfiMdjsTOCNVyD+uc2f8fC/5+SitMGdDHTWWkbs?=
 =?iso-8859-1?Q?UtwZMBZtjGZ3gHe0SkJ1LJb7V1959nueGMN499c5HAw4ruwsSh+AYYgnQB?=
 =?iso-8859-1?Q?2Fp2HG7Q7g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5ec57b-6546-4632-0d97-08de785ee7cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7928.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:23:34.6933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZX+5PH8AV9iJ98eli08+/fLC6vG9S3gKbTpkN4jGcDV7JEzFpwQQY5u41rHyb9JbI1/tWML8Va5AhE/WQqvaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-262653-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikolay@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.845];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE0381D9E30
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:40:08AM +0100, Linus Lüssing wrote:
> To avoid packetloss and as it is very hard from a user's perspective to
> debug multicast snooping related issues it is even more crucial to properly
> switch from an active to an inactive multicast snooping state than the
> other way around.
> 
> Therefore adding a few kernel warnings if any of our assertions to be in
> an inactive state would fail.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 43 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 4a1005bb68f1..106d6dd78328 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1421,10 +1421,29 @@ static struct sk_buff *br_multicast_alloc_query(struct net_bridge_mcast *brmctx,
>  	return NULL;
>  }
>  
> +static void br_ip4_multicast_assert_inactive(struct net_bridge_mcast *brmctx)
> +{
> +	WARN_ON_ONCE(br_multicast_snooping_active(brmctx, htons(ETH_P_IP), NULL));
> +}
> +
> +static void br_ip6_multicast_assert_inactive(struct net_bridge_mcast *brmctx)
> +{
> +	WARN_ON_ONCE(br_multicast_snooping_active(brmctx, htons(ETH_P_IPV6), NULL));
> +}
> +
> +static void br_multicast_assert_inactive(struct net_bridge_mcast *brmctx)
> +{
> +	br_ip4_multicast_assert_inactive(brmctx);
> +	br_ip6_multicast_assert_inactive(brmctx);
> +}
> +

since brmctx can be const in br_multicast_snooping_active(), you can constify
it in all these helpers as well

>  static void br_multicast_toggle_enabled(struct net_bridge *br, bool on)
>  {
>  	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, on);
>  	br_multicast_update_active(&br->multicast_ctx);
> +
> +	if (!on)
> +		br_multicast_assert_inactive(&br->multicast_ctx);
>  }
>  
>  struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
> @@ -1894,9 +1913,7 @@ static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
>  					 struct bridge_mcast_own_query *query,
>  					 struct timer_list *timer)
>  {
> -	spin_lock(&brmctx->br->multicast_lock);
> -	if (br_multicast_is_stopping(brmctx->br, timer) ||
> -	    br_multicast_ctx_vlan_global_disabled(brmctx) ||
> +	if (br_multicast_ctx_vlan_global_disabled(brmctx) ||
>  	    !br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
>  		goto out;
>  
> @@ -1907,7 +1924,6 @@ static void br_multicast_querier_expired(struct net_bridge_mcast *brmctx,
>  	 * if our own querier is disabled, too
>  	 */
>  	br_multicast_update_active(brmctx);
> -	spin_unlock(&brmctx->br->multicast_lock);
>  }
>  
>  static void br_ip4_multicast_querier_expired(struct timer_list *t)
> @@ -1915,7 +1931,16 @@ static void br_ip4_multicast_querier_expired(struct timer_list *t)
>  	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
>  							     ip4_other_query.timer);
>  
> +	spin_lock(&brmctx->br->multicast_lock);
> +	if (br_multicast_is_stopping(brmctx->br, t))
> +		goto out;
> +
>  	br_multicast_querier_expired(brmctx, &brmctx->ip4_own_query, t);
> +
> +	if (!brmctx->multicast_querier)
> +		br_ip4_multicast_assert_inactive(brmctx);
> +out:
> +	spin_unlock(&brmctx->br->multicast_lock);
>  }
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -1924,7 +1949,16 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
>  	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
>  							     ip6_other_query.timer);
>  
> +	spin_lock(&brmctx->br->multicast_lock);
> +	if (br_multicast_is_stopping(brmctx->br, t))
> +		goto out;
> +
>  	br_multicast_querier_expired(brmctx, &brmctx->ip6_own_query, t);
> +
> +	if (!brmctx->multicast_querier)
> +		br_ip6_multicast_assert_inactive(brmctx);
> +out:
> +	spin_unlock(&brmctx->br->multicast_lock);
>  }
>  #endif
>  
> @@ -4502,6 +4536,7 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
>  
>  	/* bridge interface is down, set multicast state to inactive */
>  	br_multicast_update_active(brmctx);
> +	br_multicast_assert_inactive(brmctx);
>  }
>  
>  void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
> -- 
> 2.51.0
> 

