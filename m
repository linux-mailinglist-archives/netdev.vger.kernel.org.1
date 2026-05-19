Return-Path: <netdev+bounces-289357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLGsEH8vDGo4ZAUAu9opvQ
	(envelope-from <netdev+bounces-289357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:38:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A705257B6C4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A41530475C1
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61E53DB65A;
	Tue, 19 May 2026 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h8tKaBij"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556583FB7F1
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183094; cv=fail; b=oEMMloE54arPy1Ehbwoi92x2DgpEK0rFtObFxfPTDCDa0v8gN/gtuwqbLqr4s7cKh7QiRAoMcwBUK+70rxKrXEvirzIDei4gARB4LsKrIrQF9FjIpun6SlZsIjf4QmorbDCOTpHOUAFUwsM1a4viDT194dacSmE4p7HwXjrLGhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183094; c=relaxed/simple;
	bh=IXJ2JEcOMmMMkvrGt3GSV3KEyinXWyHVnD0ceYN2Iqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zb2tMyxxVE1YLQQ2Rj848VyiRHh+5UsJUc/NTg8e2z29p5NBtssOi4V+fp9N3LeBbE6DFl7Nvr0OnwPF5mxBB/eJWqp24CeIdQGwdlsIa28xhvVZIK39MSOcAXfxUO+Kw+EOpphr9V506DlTbqCKX/miJJVTki4mV7cVqlfWz8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h8tKaBij; arc=fail smtp.client-ip=40.93.195.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1FtpTwwuvABI0UVli7WW5yyYbl/lsEK9c1ZP5/QFygr3i1MQE1jeArV5/Ga0VmQY7qGPK/0PN7bKhqIpYFeCloUj8rDNbLlobyFAq7IfbPnZmCsExUzyqUFWGhgI9biLtwtF9GGr+Fw/ZPC8/oqxRnp4PdXaidagYCSr9YlHJgzJGXW17dXiJFWo+aEpG8QgvbDaouh/I/Wyb8KJlgpAuQJUMkrze2pCWoXvHlVWAkbD0HJBGNxA1Vqgm/UW6oco9hy5s5px/6ifO01dFxnsIsq94Q27UV1PNDRzFnE3aVIIIS4yXDa5popRhW4S8TQ5LuiDwxYtAMOGlvgMeqSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKGe+53oNZaMSQbG94PxdGthgfVRMAQXARWlfN/X5E4=;
 b=LBeBn1fGW6/2s2tR2Np+2HBtBB9Isi61A+q/eeVjnv5zmVeFWf+cvLdX1opMHnGxp8/vA5SNUeNvu39ca/hUGdw3GYIorMnaqQYkexNyhvnTA/ZCtXC5/wY4KEs7emsyIX5FkQCM/rPwfJTWPlG+fyrkxiRDrUGl/60VCE38sgZKCyR28gJMny4PbNKo8yq6rF+xcbgGqCpFN10nSxaEkOenOK24tEYznC50EAgL3cRr7hgFryc4oCjkfn6DUiDNaURU3ftqhMBcrl3r62SLgkgnovRlCDiw3n98uaz6VzFuy20goQt/EvxgM/lofSqpD5NQWWYYXe0tZ+gN3QYKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKGe+53oNZaMSQbG94PxdGthgfVRMAQXARWlfN/X5E4=;
 b=h8tKaBij+Ee8ZQlaDVnuhUBrCAwWZKM3rqE06VfBEXBsKIHYebXikhvsPcoKs5BVJb9CIYAa/EbylT6nsAe71NJBYIxGM1TfvNlp2fT93zZaWTRMC1uztEv2qPCZrNY1Yb4fO1YvjoMcG0N8KRy7X3l3WZVEjz35+7MkRJo3Ml7Z3CxjbZz2gw1949LXoVcH9yOLZxh/KXrc3TUVp+XpOE3filQ+MemAFV5zs6qa0vUX5IzdnV+SOTfLnx+qly5QnmYvz68neq/fRdk78pKxoZRDrHPm2yMbHyGEEeTUhxgQjL6TMxIjnu/IthjGl2mcNxM50DHLxZF0taAPvqtv4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 09:31:28 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 09:31:28 +0000
Date: Tue, 19 May 2026 12:31:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, razor@blackwall.org, horms@kernel.org,
	dsahern@kernel.org, yongwang@nvidia.com, aroulin@nvidia.com,
	petrm@nvidia.com, tglx@kernel.org
Subject: Re: [PATCH net 1/2] bridge: mcast: Fix a possible use-after-free
 when removing a bridge port
Message-ID: <20260519093118.GA395034@shredder>
References: <20260517121122.188333-1-idosch@nvidia.com>
 <20260517121122.188333-2-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517121122.188333-2-idosch@nvidia.com>
X-ClientProxiedBy: FR4P281CA0301.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 217dff1e-82a6-4927-fca3-08deb5896770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|22082099003|56012099003|11063799006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	KOCkY5rIsC2p9uvDayPwZB2/TfH+NpjrSuVEIoc3X/GeV+2zr46cZSLMu6FF7YCGgn3f0gN5tk2FXUFNwchLmw8d+f+AKBBHFbxhH5CMdJU81/pmY/vivOFhug9VpJx4p1PiAG6AvjcNiQEEHd0tLTSKGqyENHBiTkA8Tu7OPhbRr9nLCCaq85+RQswud5iFvsa/8aaYnsjAg7Z9lNXx/PnLCrlLvAevlltL2Ha9qtS5NAGxH7b4zVlvBDntpM8nPfUidu93ST30ZiClTI7XoDtZsjDQAPMt8RSvhPiaBKpfVwwQWMVOb3Y+OhAzGffA4bir+NrfAkULpvTd0rOCadiw5FTa33C1sjCcCqs6s4b2VvY5oP6u1+runCwaJwa8LCCNh79sSXLYuWYI/ixrI9C9eC2KRPhh6CGjUWSMKwSPpTV1C6IXcZKu9i+uzuF24nmpEZS2jJw0w0gU2ZtGYmgRSt/ZBYiGU8ocYDSq0SgB+cZJKJqGVhv3aISPGJhWCZMJ9SsZ43eCYS6m3ww2hYHGFtvKKuudZE9Dojb1cA10LnbCjGsKD0HV8CMATkX8guKExxInHEEZnnkxy2tTmpuaGUa9yBWaRgfRB8FOHIi6g9sPoKHYJvHfYAh9kOVnrNdinPOwgECqMadCK+qbOnE01ca5otnwqrWVRH3+F8JZunK/s9kVI8liS5+oFMZm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(56012099003)(11063799006)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IEcDcsHtgiDgLAzgqoR6Hn3lf5Hu7bCWrR7h37k3RY6OlgrilF5A18Unc+4i?=
 =?us-ascii?Q?hkYZWFFIz/Jx3d8ek3GETYDdrkdkVYJpkQpcarGmO6j2vTPbEoOiejlTIBpT?=
 =?us-ascii?Q?cD7Jwkownw+HLU/NwLV1xhmsSQi56titZhqD21ZaDkZMsuJVxtbYzBh3o7hV?=
 =?us-ascii?Q?faw4niiujU7YILJIW8LT8v9mel5CwydO0Ueq08RCnFDCnai6BAMek8WNmtdY?=
 =?us-ascii?Q?1Mc4UwCz2aJAgy3GE9Ix56qug9yMAyBuT+K+iBoi33Ovyt2hCmDziEsC+dbb?=
 =?us-ascii?Q?TjNqH/et1hQGwKUAbC9qNAtiQTRYwUeL0ihVSJ+LSPtPeXYlmr+uSkvUNHTs?=
 =?us-ascii?Q?BZsSFMVO5LL8WNZumGCuM/O9onOzFPk9Num4Ga+4/LOawoni6tOqQwT7H1Ei?=
 =?us-ascii?Q?42rIvJtD7d/V3Vl/NLhkKbA16z4HEv/NhLSbLIfTJZUR5YGDWOxnOAFwQLEc?=
 =?us-ascii?Q?lzNsg4B8SiK1yAiM7gHX3NKjFaIsj7ypuEgxP2yypPxJEBER5PYgyJB3CTvY?=
 =?us-ascii?Q?RW4/qmn5+/nMh45FOLrs16I3zllHb/YaX9LiVcEkJ7YZ7NUHvmAcObPyrx49?=
 =?us-ascii?Q?rV4EiVTf7Djup3Fhnz8+0QH4yeLQvmSmPP481Kkj2uPR6KlPR5+DGGSUr71n?=
 =?us-ascii?Q?+M6M9DYZ4OmuuiMnhZPTqozPKbOJ5eEfcBXc+O+05okd1DnHn1kgMHjwy3Cf?=
 =?us-ascii?Q?DuJW257xJFBFjtCZ2cao9MFxWjNEkLEh9au/8W/Ma2mLUZSROQys7znw2gp9?=
 =?us-ascii?Q?BJ35KAUvZrqGb3F02LXPFGXGfspIaBZc9gXGr9tcyDWZ/PnzQeM2r+CvtOJf?=
 =?us-ascii?Q?uLKnlRt0vXbXnv/WnztbOTJ2UUun5Uw/z195MVo6u9PTk31RZj5Tc7fvrV52?=
 =?us-ascii?Q?Ahn2PZ8TyguujGpM/N1TiMayeaEh//yrmNQKIoK9i/b1aiOEmZYzIDPE59f3?=
 =?us-ascii?Q?/tnvOkIMbVYyVkwAmV5jTb3bcYylf8iVoFbMKhlflT5xK96OBw5BfnJL5nzr?=
 =?us-ascii?Q?W865fRWGTpYQpO2vV0qjV/Delre8csettabb+BbRO7JknE82HMx4BPDMcljk?=
 =?us-ascii?Q?iZg0LeUrUEKe6afpxGF06srg1p7gs/pUxsDof5C/FgqzTu9e18lKuXrnMjfC?=
 =?us-ascii?Q?p5f8Q26bTJbQHP7LELBbe7wBlmzdHG5E0RRMIXrdxdt0llDg4wcXQEALu2X3?=
 =?us-ascii?Q?cze0DrKuUOL3ywnRy2U99ez27VL9G2SFUDmdKTBlteuV2St8Np/VHfO/tHYn?=
 =?us-ascii?Q?JLg6K5STFPkvgyP5VWYcdSDcDPeBchWAahKkxxlOsuwz3nnqz3VuV+NNuCpM?=
 =?us-ascii?Q?Jlvy2xx4PKh+EHE/ou2EfRNofmeRNjEwd3LY8k83n0jDy8+Qsh0kaq1Npcry?=
 =?us-ascii?Q?WgVnGDfVqH4WywsSyXicKr5fKqdF/hpUCQFe0L25IvNBimlvWjxY+9CyttFj?=
 =?us-ascii?Q?1+D3Bf5WTs7gxXDccyudmG/nOcL67lnQNNqkwXIVKzPnEqXD3v8jFY0KkJuD?=
 =?us-ascii?Q?wZY5S4NLKKu7yHTl+MvNjrNlPL0KER6SbeEDI7FhnmCISG6t15SiLaienhMp?=
 =?us-ascii?Q?xiIkc4noRWivOFntFEKaTVeMtjbqHTeVEaeDWfU1Yxt9BV6km6HBjB/k2vPN?=
 =?us-ascii?Q?9vQ8lxltVcmsHx8/N9mLTwKCQCBoUXlQSfYtAZOVzGHC6VxQ3de1YGrAo5Qq?=
 =?us-ascii?Q?s12Cn40de4gTOrDO7cKY2peD3C9W8B1o6EJybR88ky4Bh2b+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217dff1e-82a6-4927-fca3-08deb5896770
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:31:28.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VF5dS4ThA18Cg+CsWA12WvawIwtyrdUWcxvcvDhqALmX7zYL6t98kJSnOv4Pa71rpWh+o8wqlGdYiH1t2+p6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289357-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: A705257B6C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tl;dr - I believe that the issues that Sashiko flagged are false
positives.

On Sun, May 17, 2026 at 03:11:21PM +0300, Ido Schimmel wrote:
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 881d866d687a..2eef4f3345cd 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4640,10 +4640,24 @@ static void br_multicast_start_querier(struct net_bridge_mcast *brmctx,
>  	rcu_read_unlock();
>  }
>  
> -static void br_multicast_del_grps(struct net_bridge *br)
> +static void br_multicast_enable_all_ports(struct net_bridge *br)
>  {
>  	struct net_bridge_port *port;
>  
> +	if (br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
> +		return;

Sashiko says:

"
If global multicast snooping is toggled back on, this early return skips
iterating over the ports. 

Does this fail to restart the per-VLAN per-port querier timers
(such as ip4_own_query.timer) by omitting the call to
__br_multicast_enable_port_ctx(&vlan->port_mcast_ctx)? 

Could this permanently break VLAN multicast snooping on all ports after
a global toggle?
"

Even before this change we didn't touch the per-{port, VLAN} context
when toggling global multicast snooping. I don't think it makes sense to
only toggle "mcast_snooping" when "mcast_vlan_snooping" is enabled.

> +
> +	list_for_each_entry(port, &br->port_list, list)
> +		__br_multicast_enable_port_ctx(&port->multicast_ctx);
> +}
> +
> +static void br_multicast_disable_all_ports(struct net_bridge *br)
> +{
> +	struct net_bridge_port *port;
> +
> +	if (br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
> +		return;

Sashiko says:

"
When global multicast snooping is turned off, this early return prevents
__br_multicast_disable_port_ctx() from being called on the ports.

Prior to this patch, br_multicast_del_grps() was called unconditionally.

Does skipping this cause stale dynamic MDB entries to remain intact in
pmctx->port->mglist instead of being flushed?
"

The per-port multicast context was already disabled when per-VLAN
multicast snooping was enabled.

It also says:

"
While this patch aims to fix a use-after-free for the port query timers,
does a concurrent execution race still exist during port removal?

When removing a bridge port, br_multicast_disable_port() calls the non-sync
timer_delete() for ip4_own_query.timer. Later, br_multicast_port_ctx_deinit()
omits timer_delete_sync() for ip4_own_query.timer and ip6_own_query.timer.

If the timer callback (br_ip4_multicast_port_query_expired()) is already
executing on another CPU, it can outlive the RCU grace period since timer
softirqs do not hold RCU read locks.

Could this lead to a use-after-free when the callback dereferences the
freed pmctx->port?
"

I don't see how a timer callback that is executing in softirq can
outlive the RCU grace period.

Regardless, like I wrote in the cover letter, in net-next I am going to
synchronously shutdown all the timers when de-initializing the port
multicast context.

