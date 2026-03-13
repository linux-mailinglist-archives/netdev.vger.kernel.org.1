Return-Path: <netdev+bounces-267482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF8cMZMktGl7hwAAu9opvQ
	(envelope-from <netdev+bounces-267482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:52:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E79D02854FD
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D434303889A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951D372B22;
	Fri, 13 Mar 2026 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D2aztcH4"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013050.outbound.protection.outlook.com [52.101.72.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109C33439A;
	Fri, 13 Mar 2026 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412618; cv=fail; b=QEcz9dnof+rCftCPa5bWoqNz7F38KTgKYmnwC93ciXEwtkdUfdON1aZ/3JIHFa3S1sk25qyl5JbZHNQ9zcKBXDalTVdnoWyZYsHBP9f9YAZc0gH6goFJJkWntY7IHGxBNFV1zlOcMfACS2HA1ANHnNDY7OcuaaNDYtm8pJox24c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412618; c=relaxed/simple;
	bh=7335WXZFj2ryOGZFvrFpcVlGYfO1w2BaxQhifzg2Srg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eUevy46zuFoOaJoNcqd4Bf1Uwv1MjTdpDAwZ5SL1KlXx/CAQ17mj6t4s3t+2amEwTDWOePki59msEHomKaT2z5yAvztDoTzWMH6immpqdEsVLIYcZLNnPAXtU0EywEaTr2C+djYl+0EPLMMM6cFZoPGOLAlr38VjpRuQVqMOLVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D2aztcH4; arc=fail smtp.client-ip=52.101.72.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WA406zJoTMXMLNf6RvQ8dXwxRW9I/hepns4Uauhht92qhr/zub6lx7/v3lHyb0HjLgZgq6Hsd24jzK4Cl5/BiSHfGebBWAAsCup1ClO6khCNWNskLzwfei8T4bz3UbEShYDL8O9Ps/u6n1EaFJJ1h2JbSdZbH9IIuqSytRCvso1YQN7oSkNM5+aEiltWJx0uHLJxTNIBjNw+jmN/R1KRorJ85vA5QGRjEhm1/1GZG1exz6pRwZnSBRlQMX5GMAu+Ap2cYunb3L7F8H3VARvasuBrpFhpz/+e8UPm6oB7IdBEUWDFMYmjoFyvZqidVWeNHwkJJr2psB+5hVqvA8WRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=It0M09BCmEnI8+9IMrnLMolOsDrhayNf5WXh9DDmsM8=;
 b=KtVVCvDzBrZ7TkDU7B3vSeMZ7/vocIqzbuP02OlAN5doLrLO10J5EuYVv7AxD7Jecpgzq1rJcd/rHcvu4LHEvFOR0PGxFBJvHLz4B8nzvL1FMbg0risDpetN43WJfybn9DjDh7uLlOGYovW8rk0MpdRs63+6zlZCBmLOoWuxu5nbnvRJK4x/eFeojMAmWQNsa+SYKA4ENRAFDRJR0WOmsQpnz7w/f/5dREzT1zW6DOGm7Jc9Bb8AUEMWP74xXOhGmTtLyXdIL+qIaD5NUTkH3puQ1uiju9Zjh+/CTq9vSq4pObFO/VZvUqEPTd2GGMYj1ZLyWuV/T6neeswIr77TcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It0M09BCmEnI8+9IMrnLMolOsDrhayNf5WXh9DDmsM8=;
 b=D2aztcH4exs9bCreGw8oJhogzKYnNIcwPGB5QbrqBkW0FBhCG8oJlBzvX6w5Rz63vGw+A5tOLwvygSKi7viXmD4IMkQFAHlNq1jv5YL0g8/8GPUcSIjZgib0mxq62ZaFfuLRQzZyHGF5zKwDrFp6sUVC16gmokc1EZ6L+TOLSs8yma3455hUOtie5Bcd5OGkyPltPIyQxtRqUl9aRMx0ibJX1HaV19zNFPZnWxTgXa78dGS4ekBviCv8ryRYABsgzX5PwonSZDqlU/7OL/ldWyDBzt5VlLw6Ki1uQbh1ZpmFhcqSArw67lLjjsfUSB8Dxwl0f49txGmhlP6SRmSK+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 14:36:51 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 14:36:44 +0000
Date: Fri, 13 Mar 2026 16:36:48 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, 
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, 
	Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v01 2/7] hinic3: Add ethtool statistic ops
Message-ID: <zf7cdxsmhclrvenz2jhelttcqxkosmqqkg3i2l6meyyrfq66hy@uqifjpxmxxd5>
References: <cover.1773387649.git.zhuyikai1@h-partners.com>
 <f53ce31d1be3e3f214f25282d7f90d43b76e1e3f.1773387649.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53ce31d1be3e3f214f25282d7f90d43b76e1e3f.1773387649.git.zhuyikai1@h-partners.com>
X-ClientProxiedBy: AM0PR02CA0182.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::19) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PAXPR04MB8638:EE_
X-MS-Office365-Filtering-Correlation-Id: b4080937-1e04-4fb2-6115-08de810df2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|366016|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ee77UBnUs0LDxmPeR9ClnAXRRi5AQH+pNBDt7JL+Q+1YLKNUAtJL+iN5b+l6UtS/JK0wgL3vIEGxXAZSph57NkpnaBDsSk55OwxVoGEldrGojnh1i5LuGd09Z2QxE3FrP/2hLEPb0mrrOfq4Ygjvdgorl1t38r+/cE1SPWx5kC9PZ1mRfD6opvfxAUmKHjrpkQlGTuwLMsRjzuI0hFLB76yGBrRzXs63Ql519HEOdfaJqoB6TIPxoRwHx2H2avxRTKH3lSM8ZI8hiDXNMnnh8SdoBru+ebL6xdF7hbmqDPrLPXtmi7DxcZpMJkIQKHM4zASJydWnTKBGt+nbVaPFsA6eyUgSStnCYupzgjrN0CyzThyIoATTLmizcLIdCsS4v4ZWGMOMetTrAcTB9o8fgn8YPA30ycAz1xswvmdBy3yciKUN0WG3gIi98+u0AkI2RTGa0ygkAKy/KAWS+Tj6SxNnyfENyveG2854arX99iWFWxTxRnL0v/m2sdDwXGtJh1EwWmL2PqXHDii74u+cmZnCgEIJzzzYEyhxANjvzai/M8bPT2Whxo+tC6HzNiuq3i50S8wvj502QCOCT6lbFlXB9ovpamihqvkNrujRoCGUTPMMgyct/9xXmWKYDaTx4jFm5Gyk8C6DSl/lAAT/ZF/ILBqKuh00APebfxCeBeisIFBn00o1/hgmL/tWTUyX38jk5cQZ4TGljJh+ET7pSaM+iCRSBNbj4Uymb4dkCPk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(366016)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RtPqu4S5Y7fw+7tKgWfL+pSLhgo4FP1V5jiowRJwk8jmUo5XFn2uA3jgufBM?=
 =?us-ascii?Q?q04/4xb9gAszIFtQ2ZeidBLCDLCfJlcs/phxcdwdoU39vpQhc832LVjJ6tPF?=
 =?us-ascii?Q?DNjZCKptbJEBeeBWqo9JjOBeLS7jPNv0vw0Y1hlxI8ED6yCXIxUhWF0wQNz+?=
 =?us-ascii?Q?sywlIpJ891VifM4Rrw2jhyd5JVs4DMKZc+bDHCIHLzemDs4h1WQnIKxZeJ0s?=
 =?us-ascii?Q?8epX6bxgPdOKhJT7WlEcZC03WHgqrK4Hm/AsAt94gpROvbtAxg3UJg5pqCNz?=
 =?us-ascii?Q?wpWNh1EMzVJENivlQlFqkI3O7s4EOOgbFiEnd7vF7uJ3LeK8z47guh97FgyN?=
 =?us-ascii?Q?OcnIWyzHYhuXMPnOzMOYO1DKR7QkmV3sUReHvvc6soSkjrqc8RS4k/G8FCXH?=
 =?us-ascii?Q?M8NTS1muQI1NLJrs7Qv+mqxKMViSNgRE8q/DFytajZ3fSZ4ZoTZRdsTEyWvi?=
 =?us-ascii?Q?pmOYZBsp8oZKxU5LC3Wr0wnIOzreb2BHjE8lz1t9la+bteKilq2ugrZValcb?=
 =?us-ascii?Q?GbWMJmg4At+YB2Ovg6HZKTUZt28K2/ooQ1GwufytdjBjKmsXn4HYS4T54Tg4?=
 =?us-ascii?Q?45QmWvg5DWkWWemsZWlNUiG0ovuv9zVjYysRKBrNHGS0moDgaRt18R/VFZGL?=
 =?us-ascii?Q?wPD3/Eum7pu+nYX/OfEEeD16L6DcwEkdLTk7CweV66IffVg9pYrYsufQU6AN?=
 =?us-ascii?Q?lLZvSlZCIkDqszOynhWQ7kuvrVJQgO2zdonq97llFjQPhAA9e284kcef7t4U?=
 =?us-ascii?Q?q8jmW8pueyRGLs5714HOFzLl/x3gSIqMdmphT2z0Bth83zhQ/BruPk077tT7?=
 =?us-ascii?Q?dfQPx+7Xnq8NDoFtk/UnPUWKSMX8GKoREVVHcSJTHi5uJPB4jZ9clqKkI4lO?=
 =?us-ascii?Q?9chm1mwslYd1xeekC6zsuyqoHlx8/PRRcFao5z6Ya16Yhwd3cron6AEK+9Hh?=
 =?us-ascii?Q?TNhExKHmLDffPYs+kSBkCRyfH+ZXdbNdeqES/GYBR2vOYmtW7/a1TGGUBcYE?=
 =?us-ascii?Q?ysS4ITj4MQNgOBHfp6UssoobjRdar1VRLD23v4u5Sifu+xK24K+3xzjbIMqi?=
 =?us-ascii?Q?GgcQ6MWF3urSoWfzQYeqdfG41CEuVoXjOa1bLW8roHxBknZz6k/FgUn8iT9z?=
 =?us-ascii?Q?36nTeG7Q4mQltdv98jpFNT43JHYacGqLZJ04NLAuGXx0yu6UDg7SRdbm01gb?=
 =?us-ascii?Q?KPzuiVVKrcZbhoeZndlvGNRG77ZZtZuwLJiifLp/Uj3iOCoTN++U2BiFggfW?=
 =?us-ascii?Q?rxOTzMrHhJ5DiM9XR8rHFihHZ0X5PcRw/5Nf559nuZ0d3+m4DwRSqXEDcL2m?=
 =?us-ascii?Q?abFudtu9rSQwnjpsgO5R5znejRi76Q7z5koXOs7xJ/aqJdvld0UQWwwChR/6?=
 =?us-ascii?Q?GuSZG1i1DNpccmkRpS+rqE9oL7mwq8lcK1n8JCHmpUOvHb59sDyGeDnSprW8?=
 =?us-ascii?Q?6UXh6PTH6N1jiuX+rrwD9HkxmodmjfdOfhlca39iwdZ3U9mWahSlJNgP1N3T?=
 =?us-ascii?Q?C+VnW9z3OzXDBvZwmzIyKFbCpqUEYeSzCm2xHNspHRWuSla6V2p8uYvJd1Hm?=
 =?us-ascii?Q?a+CU23W1qFgnVOOGli8iJdjyIjUf83QcZenAcgbMof0I/igjTkIZI8LFbjAn?=
 =?us-ascii?Q?v5WAegH1xdWM1Ku802w7QqHhjLPnoSpE5KC+tq4KyegUgWoc6HTBjKjsy0GT?=
 =?us-ascii?Q?6Fllxv9IdRWBLwTO3AdTNPRVe1t8KDRMm7YRISHrpsmUeyUcoxkHdvKvdbyN?=
 =?us-ascii?Q?A6Zl8Pf3qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4080937-1e04-4fb2-6115-08de810df2e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 14:36:44.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLdnPks7ImEIXWFGGjyPgxBfNaC4U9B9HnKtMZptLeHIQ5TXaQWM/pluz3NtH0INLeRhQYa/z30KYMEpQzF9RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267482-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,h-partners.com:email,huawei.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: E79D02854FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 03:54:09PM +0800, Fan Gong wrote:
>   Add PF/VF statistics functions in TX and RX processing.
>   Implement following ethtool callback function:
> .get_sset_count
> .get_ethtool_stats
> .get_strings
> .get_eth_phy_stats
> .get_eth_mac_stats
> .get_eth_ctrl_stats
> .get_rmon_stats
> .get_pause_stats
> 
>   These callbacks allow users to utilize ethtool for detailed
> TX and RX netdev stats monitoring.
> 
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---

(...)

> +static void hinic3_get_eth_mac_stats(struct net_device *netdev,
> +				     struct ethtool_eth_mac_stats *mac_stats)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct mag_cmd_port_stats *ps;
> +	int err;
> +
> +	ps = kmalloc_obj(*ps);
> +	if (!ps)
> +		return;
> +
> +	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
> +	if (err) {
> +		kfree(ps);
> +		netdev_err(netdev, "Failed to get eth mac stats from fw\n");
> +		return;
> +	}
> +
> +	mac_stats->FramesTransmittedOK = ps->mac_tx_uni_pkt_num +
> +					 ps->mac_tx_multi_pkt_num +
> +					 ps->mac_tx_broad_pkt_num;

Why do you do this instead of using ps->mac_tx_good_pkt_num which, at
least to an external observer, looks to be FramesTransmittedOK's
matching counter.


> +	mac_stats->FramesReceivedOK = ps->mac_rx_uni_pkt_num +
> +				      ps->mac_rx_multi_pkt_num +
> +				      ps->mac_rx_broad_pkt_num;

The same comment here with mac_rx_good_pkt_num.

> +	mac_stats->FrameCheckSequenceErrors = ps->mac_rx_fcs_err_pkt_num;
> +	mac_stats->OctetsTransmittedOK = ps->mac_tx_total_oct_num;
> +	mac_stats->OctetsReceivedOK = ps->mac_rx_total_oct_num;
> +	mac_stats->MulticastFramesXmittedOK = ps->mac_tx_multi_pkt_num;
> +	mac_stats->BroadcastFramesXmittedOK = ps->mac_tx_broad_pkt_num;
> +	mac_stats->MulticastFramesReceivedOK = ps->mac_rx_multi_pkt_num;
> +	mac_stats->BroadcastFramesReceivedOK = ps->mac_rx_broad_pkt_num;
> +	mac_stats->InRangeLengthErrors = ps->mac_rx_fcs_err_pkt_num;

You assign mac_rx_fcs_err_pkt_num to InRangeLengthErrors. This doesn't
seem right.

> +	mac_stats->OutOfRangeLengthField = ps->mac_rx_undersize_pkt_num +
> +					   ps->mac_rx_undermin_pkt_num +
> +					   ps->mac_rx_oversize_pkt_num +
> +					   ps->mac_rx_jabber_pkt_num;
> +	mac_stats->FrameTooLongErrors = ps->mac_rx_oversize_pkt_num +
> +					ps->mac_rx_jabber_pkt_num;

If your MAC does not export certain counters listed in the IEEE 802.3
MAC statistics (30.3.1.1.*) I think it would be best to just not set
them up in the ethtooo_eth_mac_stats structure.

Ioana

