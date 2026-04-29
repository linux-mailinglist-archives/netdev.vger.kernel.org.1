Return-Path: <netdev+bounces-282284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGXQHta98WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:14:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBFA4910FE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 487C6301371F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E933A874D;
	Wed, 29 Apr 2026 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QKIOJMRd"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F5F3A7851;
	Wed, 29 Apr 2026 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450444; cv=fail; b=MqQjPMabnGqmP7nP+hlqsjftYbGJU8uy6le/C8GqnC+Tv08pJurw2l/NJzIfgLVjqRURTMLB+ocrd+nyqPTy4uWLwgYR2fFZfiTtJirhxd85vdsm1llExbpm7w+ltT9dItNQ4JBFb3eDiNbdfms35NPUwgU6dEDfJb97eAuAXsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450444; c=relaxed/simple;
	bh=kQ0MiAvlPWcJMGluZFP624xnP2fo6nTS0sJG+dck1aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UpyeI/flutDnaG4t1F9gf2xPeJ4cNfh7CZVEUPlqfIH/ysnzuv9sFO6EQHXba9J6CWGHn0llFGVZfoPXW5UcXdczJnvkU4S7YqR7BTAzELqHnryxP4mBHQyqLtr6P443mDeg0HqfWBbtA/dsYU7rcrZUjG3uZPZqAwBlKC1k2d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QKIOJMRd; arc=fail smtp.client-ip=52.101.61.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvmVApMErhopIcjRd7+qmGuc/D7V4YixE5LJjixxE/1g+3puXLGR6C3gpV2xY8fEvhFzjgDVN+sew7lv+Dhe2LvY96fvyUo8faoiMWiYrMtCLeVV9LS3ETdHbdSxweqbVK+rwRSK5TqExA+rmPGDJ+i2s178r5CTKIULCCag327Dow4RMYe66ESx1z0J+soiuCub/xdkmh/3mHGUWZXSVe3YWzqtCLeL1uCQxwGRTNpSjikIySO/LVNKNXnjbVS2GADVR6JK8mTApPjVVIDd/s0+ZNPUGyW8ryIGTULG2Z7yJA+84VZ81T5Wj+DhP9yqlfvO/6UwnO3mOortMPkCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcEUVI4LiHQ701bnzZWM+cc6U2ZIjCWKs5riaJQ8r/Q=;
 b=HXxulfGs6qtFVhmHxuGE1l+elTDj570P7SjM4mK44oRCk4xXo1oo7zvdkVYwBYwbkn+IqpjIaXFSAN1L8Ugf/Ld280yQa3PXFSupC6l3xKC8KsQnUFbfdIWCJlbM+ENPhfrzScfRnn9dwqQvL6Dh1sXIQLPiuhBcjBB9hovVxlbRcGeNO8bn5JB6VROwcCxuGLQliwDV11HIwtZWE4+Sn7es6lQUeq/HZoubBgT7cZhHmx67vBEvIYVJDGC2cwYtE1wPEyXrxIdB4Xdc8+jzkanbzPMVh4eJsPzR4G/vKwznvJyzGgaQidzokVKuYp+A5qcUQNEwEqDCaIJY4TeyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcEUVI4LiHQ701bnzZWM+cc6U2ZIjCWKs5riaJQ8r/Q=;
 b=QKIOJMRdvht10V7hAYidERQ+pbHF654S/2Nib6fd4aAziXokvQ6AOYoc84w+juAhfcKOfF8NXj6EiN+LR+yfTW36fireA8u2X2feqw1FKD0XMxUScMaeoSNBMAxrcY3kfBEK+HjkXQLRy19USK/euTgiDmmljH82rsphXxufIFdpJ83RhZQlaSjz/kSHtOwUkiOK/T4r4YykfDUgj+dp8mt/pzOCpRLqGsIJkwq81yqcGDumIb7sZNFKnhXK2a1KBqhuRa918orrb6+Qh20MdJgORKdrjPBc2JL2kvdFiFEqVc19+64TVafGbP9+oSAymABqAh6dUhD9qwcMJqzsKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 08:13:59 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 08:13:59 +0000
Date: Wed, 29 Apr 2026 08:13:55 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, 
	Martin Karsten <mkarsten@uwaterloo.ca>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Joe Damato <joe@dama.to>, 
	Frederik Deweerdt <fdeweerdt@fastly.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/2] net: napi: Fix interrupts permanently
 disabled during busy poll
Message-ID: <plfaoeyx3xfujleux6gmmlku3ancnp73g4aca7ep53zijbhjka@3ylcijhron2m>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
 <20260428175134.1197036-3-dtatulea@nvidia.com>
 <20260428164004.1f6902ac@kernel.org>
 <4c45f423-ea41-4ae8-9cb0-7aca9157d8a4@uwaterloo.ca>
 <20260428173154.7b6864ef@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428173154.7b6864ef@kernel.org>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: c6652835-a92b-4c8d-2983-08dea5c7440d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	a3R/1AFcnCH4jroJs3B1eng8WNWka55DQJvKUkOvq0hB35/p1xqEvaNJQ4YYtCzqrv8t08xmnFOx+DeIcwt4VPBcRokhaQCevviXPH9EkkgUsabsoiga0k0CWQFavhko+9jCakNo5bgGfjZRRAfcH7YCiuimAiibgIAkWGttbTdn2iQFBltu5Rw7TFYrfEvr6GddYfDHeaAHSPNEu6uqszEEQZzYQzQW4+TDMqaOsPe4DdkA/QrN5gaHh3yANwrxAAoDO1slIfFsEjFBiAX7v797xhqdwPxOPMM0Bx5QsiDzI3kgKMjXHfg1+fKE8SIBTtq7KCl43a1ncXWKTRfztcaGxmb7iU+FHrRcJXmEwFH1SqD7o251Z27PMDnzhFVE9ws0O7zHauFF4Vi6t/UJNjmHln3xoUJ/vEqaiYDUJ9f+2qWCHKo21z8nmA288swVtKbUMmi7AJptFlQW7+5O3Mq0t+NXfzoRlGMrG63OS7wmra26gUpgvwH5iuvzdzqqx81b1WAYqqJ9LgEl4kcKZv7c1TGZbJ3kR0HZWCzlqByTg71yy7US5tvagB2xedOkOJeKV6eJos4kzdvqOuJJILs1W5aAQN+uxnIYXDL01pZTiu2xO/zykSY4a2iudlqm3D+9XYktf78iWuecr56oP9nfomurn5PFw4cIrMgGoReYwfY+rrgsm4og4ddVc9jRpSJ96+ul83472d4TTGepx/bKjM2lN9HgQT4cARFlOPU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+AXDKfNaIlHvRG8KwVLKCl8G8r+wlPffWc7i95eKIRowTLujTS0StVR1Wv04?=
 =?us-ascii?Q?PIjNmPV9IWNDuegzS4CwL3iaCLVpFYivpQGeEObpkMl05hK8LxR7ZzwLq9L9?=
 =?us-ascii?Q?eiWrlyUPoiTRhvUxXskYwaWvgNGGPh3uqITrx5KTRgha3cq3vqa92hobG4ef?=
 =?us-ascii?Q?76Q6/LFJq4/ILpbYQMrXy3za3jVrFrlyK1PG0/+pqSRxYavRITYnd9VfGfD9?=
 =?us-ascii?Q?+lsWyhXXpYRUABRXkf8ttqdFNSL1lFy9ut2fXu/1Bsb/heLbocNdxcs1Zn5F?=
 =?us-ascii?Q?f35ep+R06sXa4SzjZlg9XETO4xX8Qi943xqw3Tz+FKTDbNfB13s8pqaLOMR8?=
 =?us-ascii?Q?wmErQD8J8Gt8ibONN8qpXaOevoS07BhSfu7tZQU2tkrQR85Xm9bBS+FYyTUr?=
 =?us-ascii?Q?bsw8UCkCFsTpKEz8+rM9vpHAXuRF1OVL9PGestY2/e0+AOVNaretcLwMrnhG?=
 =?us-ascii?Q?mJ2Jo/nEAWTJr7V+lvNFkRtMrmtORbLf3XslZrzEB7BjbMSmXqQwsCDoBede?=
 =?us-ascii?Q?PTnJjU/yGn8XH4ix0GnhUJgE8+wc5sMR2bvWWgnp2E5ZWDM6UrRxN2ITqDGh?=
 =?us-ascii?Q?qFfxfLo9bsmfr0X+zPvXI53ZvFJ+4ZHSfzCrn8RjNB3ktG6P4tMoRhaGGkR9?=
 =?us-ascii?Q?8n2UAomdibUWC/KkkIJ5OVYuwzRWvBFCFm3thEiBtprRNmQkTzEaf7K9B/We?=
 =?us-ascii?Q?1ux/7bt9iv3Aq0LazoBlaGrv8Qw8iVUQV88mjCzLAPObt93snZE20mNCT8ii?=
 =?us-ascii?Q?aSK91hRXgPHDp1h7SI+ZqmANSoDJTezIAMPQ7fVjM3gFE90Y04KXhwCZskLk?=
 =?us-ascii?Q?qPn0HgpE9376vrwUj6HLQHXpwQAjuEYd1RwxYSwBzyB0pdpBWcwY1ERU5l0C?=
 =?us-ascii?Q?irqg/lpw68MSWvQh6c7xxhg2k39NX9X97HjZ8Z5QR4fouzzRN7kvRoa4MeKJ?=
 =?us-ascii?Q?FqoDI0QHLFAMAcYhUAfE6ksXayz1vZelrneXPMI6Dq4Lz6A4gurjxdk3f3qh?=
 =?us-ascii?Q?DWcPu/yT80be3Mm9jpWM9cao6fRTC0Sqss9cizYLQeqUPlejYU5gCuiVBRUp?=
 =?us-ascii?Q?umS4fHcQYFVOwjvxijyyyzAaP2NzAfr/RbotVnoPYi3RuYwBZiSGhv4Y/Z8Y?=
 =?us-ascii?Q?4yxrUp96btzinfvd0ZUaSmlQq52cOYuSfWkrFXHB/7irDNfXu3JhmVubNskQ?=
 =?us-ascii?Q?mOtJUouuVP9rPpQZnvyW6t60uz3B8RU+NlfJU/RplpL+1Y95B7qGMxJxcyIr?=
 =?us-ascii?Q?deWtOds4+D7VFEVhRnjlZKCTl4wb4+gcaeSUGjfusQdrDH4o4degAw3Dw5iV?=
 =?us-ascii?Q?y4DmXvuBDFwkGaE31GUuLCSzSyr4phEsELnhv1YVB4WjKGiQRvHlX08hvBT9?=
 =?us-ascii?Q?FBQqIOKfxTEFSh9t5pf50syJvQUoL68X/90sHAC0vBmRYVDTm9oCwEVSJfyc?=
 =?us-ascii?Q?+tY4NyAsYRP7M0Snwi+ysSePHtRqpOsl1iO+mHkpchOim54XKDuD/CsppMH4?=
 =?us-ascii?Q?mGYBuw4Bmp8AuHNOX/XYZg46ADrJS69NLczTY9VrSatkGzxmP+oS5WJegNpa?=
 =?us-ascii?Q?iRpmZxqR8WJRJjjtsYY2M5aZZbqPFj7nheXpb0ssWC7/mys+iueA6E/4Usmr?=
 =?us-ascii?Q?IjPV+DMugCiO7vIQ7dRWFBZPqdUa2rIDR04BIr1mtO7BKMENOK/7T3OD+eJl?=
 =?us-ascii?Q?lO8LuYulirxJsC+mddXUF2X3WIdY2NlkwZk/lM+e7wychRYaUifB1AxiGax4?=
 =?us-ascii?Q?EJxev2i7fg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6652835-a92b-4c8d-2983-08dea5c7440d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:13:59.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpHizFbv8UY4beAko2co2ulocaJW9bdB7cRwAUUMRJhM/Fy1pES4MvIdwh5PSSZc4P2d97eT7Ev5CBz9dqCvKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008
X-Rspamd-Queue-Id: 0CBFA4910FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282284-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 05:31:54PM -0700, Jakub Kicinski wrote:
> On Tue, 28 Apr 2026 20:04:13 -0400 Martin Karsten wrote:
> > On 2026-04-28 19:40, Jakub Kicinski wrote:
> > > On Tue, 28 Apr 2026 17:51:30 +0000 Dragos Tatulea wrote:  
> > >> Under certain conditions a queue can be left out with interrupts
> > >> disabled and with the napi re-scheduling timer permanently stopped.
> > >> This behaviour is triggered by the napi busy poll path when
> > >> gro-flush-timeout and defer-hard-irq are set. Here's a sequence of
> > >> operations:
> > >>
> > >> 1. Busy poll starts, NAPI_STATE_SCHED is set to avoid rescheduling napi
> > >> from the timer.
> > >>
> > >> 2. During napi poll, driver disables interrupts due to being in poll
> > >> mode (napi_complete_done() returns false because napi->state has
> > >> NAPIF_STATE_IN_BUSY_POLL set).  
> > > 
> > > Why does the driver have IRQs disabled in busy poll?  
> > 
> > The problems occurs in irq deferral mode when both gro-flush-timeout and 
> > defer-hard-irqs are nonzero and NIC interrupts are disabled.
> 
> Okay.
> 
> > >> 3. At the end of the busy poll (busy_poll_stop()):
> > >>    3.1 napi timer is scheduled and skip_schedule is set (due to config)
> > >>    3.2 napi->poll() is called:
> > >>      - driver poll() processes exactly budget packets
> > >>        and exits early => napi not scheduled.
> > >>        (interrupts are still disabled at this point)
> > >>    3.3 Since napi poll processed budget packets, __busy_poll_stop()
> > >>      is called with skip_schedule set => napi is not scheduled here
> > >>      either.  
> > > 
> > > with skip_schedule it calls:
> > > 
> > > 	clear_bit(NAPI_STATE_SCHED, &napi->state);
> > >   
> > >> 4. If the napi timer from 3.1 gets to be triggered due to slow napi poll
> > >> or some other reason, the timer will run with no effect (due to
> > >> NAPI_STATE_SCHED being set).  
> > > 
> > > And here you claim STATE_SCHED is still set?  
> > 
> > Labelling this with number 4. might be misleading, sorry! The concern is 
> > that a short enough timer (compared to the duration of the driver poll) 
> > can be triggered before the NAPI_STATE_SCHED bit is cleared at the end 
> > of Step 3.3.
> 
> Ah. Just say that :D Two pages of buggy text, y'all would have been
> better off using this one paragraph as the commit message.
> Please don't use AI for generating commit messages if that's the cause.
> It really is spectacularly shit at it.
I take the blame for this. Funnily enough, the text was written mostly
without AI... Just wanted to present the interactions in a more explanatory
way.

Do you prefer the short version from Martin or an improved version of
the long explanation?

Thanks,
Dragos

