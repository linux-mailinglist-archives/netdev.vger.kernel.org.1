Return-Path: <netdev+bounces-265628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD/mFcnzrmnZKgIAu9opvQ
	(envelope-from <netdev+bounces-265628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:22:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B1023CA42
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 716F430ACEEE
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333783E122D;
	Mon,  9 Mar 2026 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nCDU9/2d"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA533E5ED9;
	Mon,  9 Mar 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073056; cv=fail; b=W68wDt1AD7BxSjIfMoQTnPWl+vcVtc5LeWX7AB41bf6gAuhhryJNPaBVGOQZaVzQbczY+fKLzJrcq8nlL17rBWaZK+R99k0gbW5ZbYHNlRYTDleqX2IYlYHt2FO7/XicwhqEGdeH2nbFl93WAN6IHZSyomWTnBASga8VVe/GsME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073056; c=relaxed/simple;
	bh=CmGy/xrBhfOvroTHDtLIrX1U1a8A0MUJVuVTLwVa+Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mfnMrQ2D8mPMH4DB4vSV7bOQTTl3iR6FUFD6vUYp6QbCt06sRYVzZunw1AvS3xYO8U74G0u0MZJ7LJrKRf+mfwSfmrL/gjNhoOIFI4m9h9+h34RvTYfw1HFy/BchVAFUGxO0S7R2YG1EvXXBQ+CHo6zgKJye3DF+Qu43BvdiDFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nCDU9/2d reason="signature verification failed"; arc=fail smtp.client-ip=40.93.198.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEnsK+pXsEUw4CPwk0T43anvc9iHp9K5RUlfh2+saNo87I4HsbsA8GCDvuqo/hKQCKH1o4WqqzwNBEv7Gq9UGzrDYi60qLi4onoDKk+1tgXNBTZlMauSTuOemX0Jtqv03r66GR+kJND78gNQMzI/VwRBQ0Z1XsX8sSpvWremNW4n5WhNl7X0S48CvMwGdi6CYEm0K9iQhtwQ2Xxs+BFdkF8IFQgxU3ige4AZr+GuAI0zpUsRtbWlbJU33D2wmC3AoxC5IisbxTN7sLfms6Sjy4EiBT9irS0fEQymE44CDIC3l0/O7O4at+yySELw9O8mnetaPsji8kEJGwfReYIqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpn4nRH92aCttYa3vQXarDUvZcf4Qf0mtK+EcddkjDw=;
 b=di05C8B2N/4t/gmhOW6ZuWcJJryQdB8bl00mvrp6cnxQd8JId6VylsBOameKpE9wUTleJxrneVU764g8VfF1sQvMFfyKijqqB+tQFMcKFwerT/iYYfmh6EwCgBtGq0Becm/G7yNJxOtvmh21XK6rIgMvRno79b4e4BOI1SqNS1VZ2cxf2vTggo5Wl1IC2WxBV6i50QzVC4w/XlM0ANPVqyAeM/hQRaQMq5P6Q8Yg0BKA+HuJk5s5EZgHd0J31KU8iNf5pIXHfiAHkKL5j24hqmecA+6Fypn0vTZqi4ce2fK3Bt77thpcVJ4a6wpat5b2nXQITBqMhRW7aXr8doCrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpn4nRH92aCttYa3vQXarDUvZcf4Qf0mtK+EcddkjDw=;
 b=nCDU9/2dqM9MC4+1g2ZHPU3ITBYVHe1j7fM/7KD5N0lelf6SceaiTYyl5rxXL8ZR/OZXeL17hpLkMmX1qvBd/pyvZT/5H0g0ModUQ/eVHZUP2zldB0hqKrYAaFzxRYTEGWzdk7qY3P4uWcMXPciniON32uX7SmZvDAlH4PoQTkBYWefKQq0flQcC+t9QNa5Hmd/I6eFh5LEitewoHAwPHuIPfze+UgpQlL6nWcdcqeHEo4ssDcz+UZwmnJcynce6HuoKdcpVVLCt7AoClb45Qo9YVirUrOEfvgRzefEwtG1OyaUAcr9a18/9JoMDXLB/EiliqX8z+QTTpQvtvkOooQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 16:17:29 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Mon, 9 Mar 2026
 16:17:28 +0000
Date: Mon, 9 Mar 2026 18:17:18 +0200
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
Subject: Re: [PATCH net-next v4 11/14] net: bridge: mcast: track active
 state, prepare for outside lock reads
Message-ID: <20260309161718.GA2012933@shredder>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
 <20260307044548.5230-12-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307044548.5230-12-linus.luessing@c0d3.blue>
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2ae323-362a-488d-ed23-08de7df75b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	XUFznokTjH2KVv2FNkk5XSvqwbB6jJYsZIJm0OY4DoReLP2nDW7rO2QtvX3Umz6Z9gQDMN2T5DP516KISG4fLZ0q7W3KekTVFuBgqeZcQ05+92o46HLeoxJzax4EcF10yg6qcfMTk0xZS7D4bdTnHKQ80GpwdG4j1dE4B4t/Z06BS+L9BLzz5OuKsiAMjf79seunF89QdXnnQScXL2n/cppsGjs9GlN3nF6sMvEuOWh+ZNsRbyUBkcUOvVdPwp20AHPhiFzuoOS/wlXmgEDpZzsIzeAlka3y+p1AEtlfUBhdIE6Lq7P5n5fYaXRmlQ/BYMXVn/MBh4DN+5Zf+b/E36ugTw09kJc2Ta+vakRNYzWMscw5+eosAnMNREI25AiAEDI9j7G8vpGUbw4Ewnh+1SFYuzc2pNt3HW/MkWEfRdJOZcYNbxaICsv5aVBiZbLIZVHb9NSgaSeIGfBrg1Q1rxEOIvR21bHbR9xsI+Xx/2/GX2K12tCPGeHvuyF1w1Ou/eRVp9IAI1UFo/KUye/PVsSSpEdyxis6CuKBoa+xcOmikX1pg3w/Mh/SNja9jhxY5E8q3g23uN+WDOhUgGE+yH2m7xK2dul3Njy3OJNTK9WYZUgroo8Mf4pkPTKVRjcepuQWwNmN631CSY+CxAY0S4WaHirtZmChoP94uPj+NN7ZK2bFwywJymEEgXNVgwXjrHINAIG4esXFe6h9KjRgPZ+US+r+P2HvjeGPRl4fQvQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?e5keXBLAfVYgIZfD/rM0vG9f2GmPltZM1odWPMtcIDkBN8W60PDQEE/5xb?=
 =?iso-8859-1?Q?mXuItFXfB6ofv/PYMaZ9P63EnMEv++BQVcnbpSB++BfAlKA4U8zGxGEHkZ?=
 =?iso-8859-1?Q?gM+Hk4/9o0mFSnbdF49Rt3f6SSTy6wHZXcVIym79Uok2D4jW3SRa8zI9jh?=
 =?iso-8859-1?Q?QqdoMFcYX860im+olbVgPpMYk5LT9dqsJ3Qx5hiMB4uusHsnhMrvPbaqMa?=
 =?iso-8859-1?Q?eUufO/3j2NttlF/ckEC9IEOnBF2FTpt7bHU7Hpb71n95VOanqkMyW5KM/Q?=
 =?iso-8859-1?Q?xLgP6Q1aIpOU1PNjTXvnFKMRm95ubCpWMG244xcvwD8BaHrhPgouNHwA39?=
 =?iso-8859-1?Q?QFsC4cHZFsn66mFu6Dxs0ITnG6kQRMvV4z+pnl7E7ySKjUsNGEQG4AUhAd?=
 =?iso-8859-1?Q?C5K9smuE6/DAUcIDw+RUPcyxAYi2A110nQBqPGmFx9KGhdEoxGEzPfCRaJ?=
 =?iso-8859-1?Q?w09MMROy6c2CgEhqaC2QUem542SrSSJJvzVjmZJzzujTtJcUdgpocdzORS?=
 =?iso-8859-1?Q?mF+aMR53FwVMW0QqsoT1SpLXA3w3Ma+cLk+rd2asZDk1hjwAoCMcxNAISq?=
 =?iso-8859-1?Q?hdPuj6W7ElJTAw1hvAJgayYN0ngwFj9D3vb+AM+6rK3uLm6SDxfEoWnLxg?=
 =?iso-8859-1?Q?TBzJIllrso2BLvAzfvN1HozUYuvHYOShw+yUXww/Xn7mthfuLaJgvtyVrj?=
 =?iso-8859-1?Q?AWmsGlBycKo9mVli2i2fv60vZV3o8cBs0I5r9s6tQic5e838ziwJ1JFOMK?=
 =?iso-8859-1?Q?Vg8NCsKt7ZD8hf5mvZj/AovTZ4tkYs7faV8ROCI22DGcHfXpQypiXHEL+q?=
 =?iso-8859-1?Q?wdfTuhs2E+5gi8I8yxT02ApODLFbuGlUrpYspldBmxgYTvgVgT9QusJMck?=
 =?iso-8859-1?Q?hNzWfPMoSxpMVu9UDTOzFhSK4zSaMdzIvG7b80Oq8zRUi2JkpBzr1juQwh?=
 =?iso-8859-1?Q?nVEpZJNyDfRMkK6rCA/ElXdG5mp0mP/5vBajdevOlZxcNBQXRAAucrt4s4?=
 =?iso-8859-1?Q?hteA3gucw7tvAY33r0D4v7by2UF9EWwXI5PPfa45/6QZrMMPnx55U+dOHC?=
 =?iso-8859-1?Q?g+26nBsv/qvlsSITU+gfjTgpTUIZcJbpVxR1BgeGQoaGyum9ssCFB6QqPd?=
 =?iso-8859-1?Q?RAUE6KUSyZ0JU/f7Edt9nJWtEVoKCroRKQMFcjWq/+ibL48Ez6OxydaA7C?=
 =?iso-8859-1?Q?dJ4+9y6ew1fcQMRRstZXgPTJw6XvpMNEe/40fuzzVwxCN3pobebD+sI6HU?=
 =?iso-8859-1?Q?5WlbFen7g1ixaHv0C+R2fPGhffEMwMLxi9Vs/+/axoi2zJRL4zU081j+ah?=
 =?iso-8859-1?Q?e7brnByOsCaQNEdywVBAAuHhABm2Rd/Eyu0V1B1EUKAsiI+52OpXCAFfti?=
 =?iso-8859-1?Q?gj7C/mVfh3PQqXzH4LBFy8L6mV9A3uroy8xRHgPjoQxfpBg16Y6/sjVzo8?=
 =?iso-8859-1?Q?DlbQ2Tp1kAA9EiuYKJay0D5U75JuNckO13XiZpLVxF0yLCfx6izZBKmoKw?=
 =?iso-8859-1?Q?zejibpjyLwaFaEwrt5Qpgi58LPRRAbTlfY4tGcPjr2/qmspUa6u792SEHm?=
 =?iso-8859-1?Q?9RHmPMaB1SjUjQAQCByK32yzo2umUVpUNAMwC8w5J7ZYi0lneYPuqVx2E8?=
 =?iso-8859-1?Q?nD9/U58XgOpF/7hFNBeuVL7h0bPLsLdKgs7rsKTYYXtzkb9Howg5WzQd/z?=
 =?iso-8859-1?Q?+WRaTJK/47wyPqJKn39DIA3Wc41/N/ltKBmvIphzfl9bDae0IPKhAPgUPV?=
 =?iso-8859-1?Q?8pVUSJsfIUfu26JHGvIYTJJaqzDHRjh69qQkeuB9HQwijTvsU3gQn5leXa?=
 =?iso-8859-1?Q?4kWWhLYHKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2ae323-362a-488d-ed23-08de7df75b72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 16:17:28.4758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPLAgUE+s/E7vKjeSIyncZyWYxIuUV0OYekdr4O9arQM/OIg1nYZl8ANqSX7cmNNHEmhFzSuP/YCAA+TlKzb4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
X-Rspamd-Queue-Id: B1B1023CA42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-265628-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.304];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 05:45:45AM +0100, Linus Lüssing wrote:
> We are updating ip{4,6}_active and check all variables their state relies
> on while holding the bridge multicast spinlock. However we are going to
> read it without this lock in a follow-up commit on fast/data path, too.
> 
> As these variables are only booleans this shouldn't be a problem,
> ip{4,6}_active will be loaded and stored atomically. And those
> read sides should converge eventually. But to allow tooling to verify
> this use the READ_ONCE() and WRITE_ONCE macros.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index cb78f9555db6..6faa484dede7 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1085,9 +1085,10 @@ static void br_ip4_multicast_update_active(struct net_bridge_mcast *brmctx,
>  					   bool force_inactive)
>  {
>  	if (force_inactive)
> -		brmctx->ip4_active = false;
> +		WRITE_ONCE(brmctx->ip4_active, false);
>  	else
> -		brmctx->ip4_active = br_ip4_multicast_querier_exists(brmctx);
> +		WRITE_ONCE(brmctx->ip4_active,
> +			   br_ip4_multicast_querier_exists(brmctx));
>  }
>  
>  static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
> @@ -1095,23 +1096,26 @@ static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
>  {
>  #if IS_ENABLED(CONFIG_IPV6)
>  	if (force_inactive)
> -		brmctx->ip6_active = false;
> +		WRITE_ONCE(brmctx->ip6_active, false);
>  	else
> -		brmctx->ip6_active = br_ip6_multicast_querier_exists(brmctx);
> +		WRITE_ONCE(brmctx->ip6_active,
> +			   br_ip6_multicast_querier_exists(brmctx));
>  #endif
>  }
>  
>  static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
>  				       bool ip4_active_old, bool ip6_active_old)
>  {
> -	if (brmctx->ip4_active == ip4_active_old &&
> -	    brmctx->ip6_active == ip6_active_old)
> +	int ip4_active = brmctx->ip4_active;
> +	int ip6_active = brmctx->ip6_active;
> +
> +	if (ip4_active == ip4_active_old &&
> +	    ip6_active == ip6_active_old)
>  		return;
>  
>  	br_debug(brmctx->br, "mc_active changed, vid: %i: v4: %i->%i, v6: %i->%i\n",
>  		 brmctx->vlan ? brmctx->vlan->vid : -1,
> -		 ip4_active_old, brmctx->ip4_active,
> -		 ip6_active_old, brmctx->ip6_active);
> +		 ip4_active_old, ip4_active, ip6_active_old, ip6_active);
>  }

This hunk seems unnecessary? Pretty sure you can leave this function
as-is.

>  
>  /**
> @@ -4269,7 +4273,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
>  	brmctx->multicast_membership_interval = 260 * HZ;
>  
>  	brmctx->ip4_querier.port_ifidx = 0;
> -	brmctx->ip4_active = 0;
> +	WRITE_ONCE(brmctx->ip4_active, 0);
>  	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
>  	brmctx->multicast_igmp_version = 2;
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -4277,7 +4281,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
>  	brmctx->ip6_querier.port_ifidx = 0;
>  	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
>  #endif
> -	brmctx->ip6_active = 0;
> +	WRITE_ONCE(brmctx->ip6_active, 0);

Is this necessary? Who can read the active states while the multicast
context is still be initialized?

>  
>  	timer_setup(&brmctx->ip4_mc_router_timer, NULL, 0);
>  	timer_setup(&brmctx->ip4_other_query.timer, NULL, 0);
> -- 
> 2.53.0
> 

