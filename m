Return-Path: <netdev+bounces-269916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPmQM25MvWlr8gIAu9opvQ
	(envelope-from <netdev+bounces-269916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:32:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F82DB069
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A69AE30193A8
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0F93A8737;
	Fri, 20 Mar 2026 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ql9/XOmC"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9181A6817;
	Fri, 20 Mar 2026 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774013313; cv=fail; b=uv68tkgHDuPAEz2nHM4M9ArmGcuGrt4ZLiwu4Y3tvXsu0zurT6PWPbDMYXE4TLD848tJt7zeICt8ydrzWJIhfaF4tpZy4OZF1W1apJNYjq8k3dEQVCUa/m6fiFjxytfw1HFKgSeKnoxXkxY88PK0CDtrlP59bWvsKUlykFKBnow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774013313; c=relaxed/simple;
	bh=aK7EdxpMrzAybX8WlL7QHQNDt8oMAe/lYv3vFrc3P/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g38zlbd293C0QJY0hSiALU84bQVloFMeATW6cm5sgUErkr15dD9WTTwP2QSYZYowloqlBu3TndigHuHaGHz4w4urdMK+fN22xgjqpBeKbEdwiTlgPXVuT2wB+iHiuiaznBc9SVQV7/y5Y5ZAtSOAx94DU3r1QrUAYOcRNYzwePo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ql9/XOmC; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5LWnfMrSnNLg3k/+cWDCa/FKMN8iWsiPxCiZsLUeLkgCU1xDgSmd/DYz8PFNUoj0iyVQWIX+mHSY0vV/XhFGggwYnmxew/rigQ2p0beDTvd+P0MQjWIrIn/Yj9bNirP+ahYlXt3iKOeybabdlRx1nUmkToluF2k7vcdQ67CjmGX0iplNgifF7Z834Z5bMIOBiBHuNgJdzHdhKQvCnlJt6B67Eqy/IHzxPgc9w8nZ7Ow1sVj6mwC/8Ccls1lncip+uLiBxR1EuGs2D401mmK7tIeE1cUUUrnYq40UIeAViGuP0I74zQQPvoqPJzHzmT3OF7rvI5Im+G8WzBIETfBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chrgUOo7jgAe4Dn2rmeyIkpePMEgYd0nDLhfPHaqhyw=;
 b=HHr58bZvWx4tT6QnvFI9Lmlvt46+JU9g4FTvY+GOOV9fz1HLGGrzTdplHSGQglbwuzD9fjQo6JY0cH45J7G0OMsJp5vI1Z+17zVq1rkiDVVcXmyXqMkNDGtPSbDtMTafBCbC8//h3vGFWTbKtSG+YO2s8d4pRp6p7cw67sOSlcc7XLh54chxxIs2+o6hWYHWkhgiDPwiPbQFBTII22u2uM1fRVVH4iCHAFduXp2PZX8xoSM/qStNzehZJYCFCg9uwB06LHTeaSrO6zK0QynuJcUznAs3K2Hg07iFmdZgDNev/NSsivuwDYS3L2UgnxETL+EDdfbKGlNdt3J2+B9IFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chrgUOo7jgAe4Dn2rmeyIkpePMEgYd0nDLhfPHaqhyw=;
 b=Ql9/XOmCk2vplWowoKBr54in13wNWozqFz4QJqKVlKGSkXh9hK44iMEvDd8g+eV1t0/Y9pBhatRXPREQA9omMe7DOh2sm+zrWZRUCfdpSFNdNGlSar7OzmJKWVVFDJsyB2q4S2tJdeAGBzqqMbHLaYhbe7rq1pNPmfkVns92dEMYra1Q5lE9vuQF0uGMwL1KEtTJunhFh7zM/JOtW2p2766xu4qBZOBP9nCH6Ov3z4grU2zp6QkaZ5HzqUaqW2ERLe2hat7CvLBYQhzSEGAfkMVVNTtgMsAYU39rod4mUF3ctz6CaZq8T1J8uHDed+hCaLZ0n8sspDe5OTwPQ67c6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AS8PR04MB9048.eurprd04.prod.outlook.com (2603:10a6:20b:443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 13:28:27 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 13:28:28 +0000
Date: Fri, 20 Mar 2026 15:28:25 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, willemb@google.com
Subject: Re: [PATCH net-next v3 3/9] selftests: net: extend lib.sh to parse
 drivers/net/net.config
Message-ID: <7qkagj353ljtnn57ym24lqwma4uahu37zs435kevfqzhf4fijt@gpoc3wygxv7l>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-4-ioana.ciornei@nxp.com>
 <87ldfm91y5.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldfm91y5.fsf@nvidia.com>
X-ClientProxiedBy: AS4P192CA0018.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::7) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AS8PR04MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: de604b1b-52df-4930-ac55-08de868492a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|19092799006|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zE3VQ1RoByTw7gxr8EBZMuozZ8kx83gxlXT6mif7e3vFuqKsozARiIlzgq4FTPi+q6pl2fPgcNJycw3PYcRuADCmtl9iHzEYx3FCTiS6Ihcb/W9u6Pgpjz4evqRerhKwtq2qY9erHpWjYC4X1/3Ic8kGT1FL6tkgrRsQgILaY/Gma6d2KN/02GOVhi7NJPVzy0n+q+B9+in9te5/LO6DPmPz00pZmKjnMllrWRG35Q1m3+s1GkiEnCpUOiXcu1OXQ3E5R1n9pGUk3ylrS+BkxtolK+be1pfhS18njcGF8khvt3WEEkucMsTov7AN4Nu7S2BslmTTo3lqGt7zdJL4XN0FDB20EsCTs8G0uqvpBNMSzpHVHOXFoWabxAeQu0ATmnISk6syCVRAjb7OQtKHBlMYOpSWGLQoDftssU8uhiehdVy6mL/jX/nt46ZJjH6DbDtvjZUBiC4R+s5niiTw8yWg/6IplFwJ/XSW9oVE5lKKCWd14lyzNuv/eo+JANRLzAqgNoADAihTrTJBtOq2kEc1rS/43T0VnbYFUCg88brp2Y4fFzPU9IL6N+zbceSgDkEtcqNbZPH7C6WeOl+CMinMIJD5b4DqIwhDHQ/8cqwRKHRXahS0WhXDBJiyInv97rQfiH9dtqJdiy0vYaQlawY8UJRLjpvc6GXGd/fOhpuZPYV7hQ7SQXEo31er9QnlDMcbENNAqRaUGtLTEvAIRXJ3/ceFpKtidAQOMSHWEXw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(19092799006)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xydfWgD+ci7MiSVi0i9eQLa2AIcphYDtqmBMzvQmyaoD/7yeml0qw83vKKwR?=
 =?us-ascii?Q?I7KwGSXkmsvIX2BoE5jnELvag3mkCkM96LMFQDQbI4bWNCKpscHqyrrsAkzv?=
 =?us-ascii?Q?716w9/kinOlyEDKn5ZaidaxrAyldNmEXjnTODcwabLC4vTFRdjW66dReu1+N?=
 =?us-ascii?Q?M7LxU+RGvcQi9+qp6dBXbzh4acZkyBSVZL0XIYqa6o+KEsMLT7mIUL+BiTlT?=
 =?us-ascii?Q?Ii/8eAqczV/Q+dk8Q1izhjA/wdIQs6DdaOoNAVA6PMF3IcBP8VmeOMksro8j?=
 =?us-ascii?Q?S1Fx2iQhnZXbQtNzF2e1dSkxDQDp6TZq/b0xnUqs3OaaWFNiDVsC181GciFQ?=
 =?us-ascii?Q?GUw47y4ttZg6RMi9PowoUxJX90FmAUGfitktHdmypmwI2A7EHtc3JENflJFZ?=
 =?us-ascii?Q?98MdC4OATbhBpV/5rXD8NI14sX00cjyNhfeHz+Ks5RKq4s1rqpZtvyOWcMKZ?=
 =?us-ascii?Q?Qwn+ceOuqGFMdC0QMDSav1nwv5d9NhlgLiN3lCxe4aYCPfVFshdhmNysASoq?=
 =?us-ascii?Q?6IQ93CLltS1Rg2OuCNBHubeY29nArUyoXy+qLYB4sCqJTYY6oT/skAwIVUdI?=
 =?us-ascii?Q?6+3e5XARFxi/Y3wH6THQ23lH8mREO4Actbkg0+3bnyQxTaJWh+FQIheqL9QF?=
 =?us-ascii?Q?q2i9xK6uwmcipl/RajHbodfhytg99sNs0WnJ5NJ7D5TMfxw3eojMRwQF/0uT?=
 =?us-ascii?Q?wURUVwcVTK/8YLFkICfB1YF57kz0XmVg8Il2gmIyBSWjeLWiV7Lo2GJgK617?=
 =?us-ascii?Q?UDpeXk//PDNjFr99vAXPg59s4iyuqoSDP9u0IcXrp20PbgI5f/acakhp85Xd?=
 =?us-ascii?Q?mt3RKmN+sF7/yYFUTK1kCxp+qcC2DD44/A3b7kkviHhJMVE2vHyzRaDw5u+8?=
 =?us-ascii?Q?4rTIQJBdzGpa/kvyb3wZo1cBMnKsee+Wjbc1t2x1OlBtSZ5ILPeJsnPyQ/Y8?=
 =?us-ascii?Q?qEsO5cUL7zz1IhELRmupURqWCvhC245ifyW4p9WTk3LkjSHUB2qdOnAE5PYj?=
 =?us-ascii?Q?HSO54OZIQp+fhaj9nmqJ00nTTMskp599bl3oFyN7r2Q7euBhFmF6Du6P2ZaI?=
 =?us-ascii?Q?SslGH2oD2jTztCvc0N7waNS6bnN4SJadMgYcg8kRMNU+AllgfkH26TecvvIv?=
 =?us-ascii?Q?tIytu6Agq4bhCmgZ/A0MiprulBlfyGBKjfogzPLiw9wYNojsTePM5E9r4XNL?=
 =?us-ascii?Q?YGi0lDcZ/0hvflKzM8TPCq3Sro35dvx4rlLHdB6JUQW/kWgG18BvordzvT6Z?=
 =?us-ascii?Q?mSfXRAcfOqjUPKkPQpwarbItLvh7hQNaLlfn1MmKHuWcaK5schO+429oK3f0?=
 =?us-ascii?Q?qYgZAqIzsAqlsy82owT+3EuubqmTy8cjLCOVI6rIPG/76uCPS1sao6TuNp0c?=
 =?us-ascii?Q?e0SusNm7K6zid/vaA9K84sdKwLMzXNJe/xof6DLcs9ITinac4r3NLzCmXgIO?=
 =?us-ascii?Q?Q4JQgQHNUA2xG2nNrWhdteu56vOkJmEt9rknKnm4q7s9I55g+nmXCIZu/pQb?=
 =?us-ascii?Q?hh9tcRoxYyyC3WCLWL3Y1D39qSC/9dLUhE4beA/Ep3Sj9ZFVKUNoslIojkOT?=
 =?us-ascii?Q?lX+KAi/sWZwBQPgnTXxCOKbZBnsTxP5dAKnxE/MQ0VagGVS3CtgGM+qNeFFR?=
 =?us-ascii?Q?ddm7h0DiIHgKFhUki0Teq0IKBd5ki06H+vJcsFx/9kq/+0iob/M7dn2nBkrQ?=
 =?us-ascii?Q?FgRLddMTd/q2pXwAMyxnxH33rT6YfZoRjsKte87SOaLck9e4Ui41Mp7uowED?=
 =?us-ascii?Q?wAl+zMXGPA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de604b1b-52df-4930-ac55-08de868492a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 13:28:28.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeOJMZwxQb9gZHc6GTuhJyTEmyuIge+p1dDQmA76YbWtRNGO2N6g+MJNw1t9hET5Kw7B2wm5B0Y0cfu0zuSPAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9048
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
	TAGGED_FROM(0.00)[bounces-269916-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lib.sh:url,env.py:url]
X-Rspamd-Queue-Id: 822F82DB069
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 11:19:18AM +0100, Petr Machata wrote:
> 
> Ioana Ciornei <ioana.ciornei@nxp.com> writes:
> 
> > Extend lib.sh so that it's able to parse driver/net/net.config and
> > environment variables such as NETIF, REMOTE_TYPE, LOCAL_V4 etc described
> > in drivers/net/README.rst.
> >
> > In order to make the transition towards running with a single local
> > interface smoother for the bash networking driver tests, beside sourcing
> > the net.config file also translate the new env variables into the old
> > style based on the NETIFS array. Since the NETIFS array only holds the
> > network interface names, also add a new array - TARGETS - which keeps
> > track of the target on which a specific interfaces resides - local,
> > netns or accesible through an ssh command.
> >
> > For example, a net.config which looks like below:
> >
> > 	NETIF=eth0
> > 	LOCAL_V4=192.168.1.1
> > 	REMOTE_V4=192.168.1.2
> > 	REMOTE_TYPE=ssh
> > 	REMOTE_ARGS=root@192.168.1.2
> >
> > will generate the NETIFS and TARGETS arrays with the following data.
> >
> > 	NETIFS[p1]="eth0"
> > 	NETIFS[p2]="eth2"
> >
> > 	TARGETS[eth0]="local:"
> > 	TARGETS[eth2]="ssh:root@192.168.1.2"
> >
> > The above will be true if on the remote target, the interface which has
> > the 192.168.1.2 address is named eth2.
> >
> > Since the TARGETS array is indexed by the network interface name,
> > document a new restriction README.rst which states that the remote
> > interface cannot have the same name as the local one.
> 
> Isn't this going to be a somewhat common scenario though?

It could be if you the remote target is another system just like the
DUT. But I couldn't find an easy representation for the relationship
between interfaces and their targets that also removes this restriction.

> 
> > Also keep the old way of populating the NETIFS variable based on the
> > command line arguments. This will be invoked in case NETIF is not
> > defined.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> > Changes in v3:
> > - s/TARGET/CUR_TARGET
> > - this used to be patch #2/9 in v2. Swapped the two patches so that the
> >   run_cmd used in this patch is defined earlier, not later.
> > Changes in v2:
> > - patch is new
> >
> >  .../testing/selftests/drivers/net/README.rst  |   3 +
> >  tools/testing/selftests/net/forwarding/lib.sh | 130 ++++++++++++++++--
> >  2 files changed, 124 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
> > index c94992acf10b..8d8d9d62e763 100644
> > --- a/tools/testing/selftests/drivers/net/README.rst
> > +++ b/tools/testing/selftests/drivers/net/README.rst
> > @@ -26,6 +26,9 @@ The netdevice against which tests will be run must exist, be running
> >  Refer to list of :ref:`Variables` later in this file to set up running
> >  the tests against a real device.
> >  
> > +Also, make sure that if you are using a remote machine for traffic injection,
> > +the local and remote interfaces have different names.
> > +
> >  Both modes required
> >  ~~~~~~~~~~~~~~~~~~~
> >  
> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > index cf40cb766c68..fb5aa56343e1 100644
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -3,6 +3,7 @@
> >  
> >  ##############################################################################
> >  # Topology description. p1 looped back to p2, p3 to p4 and so on.
> > +#shellcheck disable=SC2034 # SC doesn't see our uses of global variables
> >  
> >  declare -A NETIFS=(
> >      [p1]=veth0
> > @@ -17,6 +18,26 @@ declare -A NETIFS=(
> >      [p10]=veth9
> >  )
> >  
> > +# Array indexed by the network interface name keeping track of the target on
> > +# which the interface resides. Values will be strings of the following format -
> > +# <type>:<args>.
> > +# TARGETS[eth0]="local:" - meaning that the eth0 interface is accessible locally
> > +# TARGETS[eth1]="netns:foo" - eth1 is in the foo netns
> > +# TARGETS[eth2]="ssh:root@10.0.0.2" - eth2 is accessible through running the
> > +# 'ssh root@10.0.0.2' command.
> > +declare -A TARGETS=(
> 
> This is a helper array for internal use only, not a user interface. It
> should just be declared suitably close to where it's actually
> initialized. It doesn't even need its own initialization, there's code
> down there to initialize it accordingly.

Ok. In v3 I added the fallback to run on the local system in case either
TARGETS is not declared or the entry is not valid so I can safely remove
this now. Thanks!

> 
> > +    [veth0]="local:"
> > +    [veth1]="local:"
> > +    [veth2]="local:"
> > +    [veth3]="local:"
> > +    [veth4]="local:"
> > +    [veth5]="local:"
> > +    [veth6]="local:"
> > +    [veth7]="local:"
> > +    [veth8]="local:"
> > +    [veth9]="local:"
> > +)
> > +
> >  # Port that does not have a cable connected.
> >  : "${NETIF_NO_CABLE:=eth8}"
> >  
> > @@ -340,17 +361,108 @@ fi
> >  ##############################################################################
> >  # Command line options handling
> >  
> > -count=0
> > +check_env() {
> > +	local vars_needed=("LOCAL_V4,LOCAL_V6"
> > +			   "REMOTE_V4,REMOTE_V6"
> > +			   "REMOTE_TYPE"
> > +			   "REMOTE_ARGS")
> 
> Given how much hand-rolled code is needed for cross-checking local x
> remote config symmetry anyway, I wonder if this whole thing should just
> be very simply:
> 
> 	if [[ ! (( -n "$LOCAL_V4" && -n "$REMOTE_V4") ||
> 		 ( -n "$LOCAL_V6" && -n "$REMOTE_V6" )) ]]; then
> 		echo "SKIP: Invalid environment, missing or inconsistent LOCAL_V4/REMOTE_V4/LOCAL_V6/REMOTE_V6"
>                 exit "$ksft_skip"
>         fi
> 
> Then you still need a manual check for REMOTE_TYPE and REMOTE_ARGS, but
> that's still just three checks all told like the current code, and we
> get rid of the double nested loop that's kinda tricky to understand. It
> doesn't look like the generalization really pays off here.

I took as an example the _check_env in env.py and it got to look way
worse in bash than necessary, agreed. Will simplify it, thanks!

> 
> > +	local missing=()
> > +	local choice
> > +
> > +	# If a choice has multiple comma separated options, at least one must
> > +	# exist
> > +	for choice in "${vars_needed[@]}"; do
> > +		IFS=',' read -ra entries <<< "$choice"
> 
> Entries should be declared as local.

Will do.

> > +
> > +		local found=0
> > +		for entry in "${entries[@]}"; do
> > +			if [[ -n "${!entry}" ]]; then
> > +				found=1
> > +				break
> > +			fi
> > +		done
> >  
> > -while [[ $# -gt 0 ]]; do
> > -	if [[ "$count" -eq "0" ]]; then
> > -		unset NETIFS
> > -		declare -A NETIFS
> > +		if [[ $found -eq 0 ]]; then
> > +			missing+=("$choice")
> > +		fi
> > +	done
> > +
> > +	# Make sure v4 / v6 configs are symmetric
> > +	if [[ (-n "${LOCAL_V6}" && -z "${REMOTE_V6}") || \
> > +	      (-z "${LOCAL_V6}" && -n "${REMOTE_V6}") ]]; then
> > +		missing+=("LOCAL_V6,REMOTE_V6")
> >  	fi
> > -	count=$((count + 1))
> > -	NETIFS[p$count]="$1"
> > -	shift
> > -done
> > +
> > +	if [[ (-n "${LOCAL_V4}" && -z "${REMOTE_V4}") || \
> > +	      (-z "${LOCAL_V4}" && -n "${REMOTE_V4}") ]]; then
> > +		missing+=("LOCAL_V4,REMOTE_V4")
> > +	fi
> > +
> > +	if [[ ${#missing[@]} -gt 0 ]]; then
> > +		echo "SKIP: Invalid environment, missing configuration: ${missing[*]}"
> > +		echo "Please see tools/testing/selftests/drivers/net/README.rst"
> > +		exit "$ksft_skip"
> > +	fi
> > +}
> > +
> > +get_ifname_by_ip()
> > +{
> > +	local ip_addr=$1; shift
> > +
> > +	run_cmd ip -j addr show to "$ip_addr" | jq -r '.[].ifname'
> > +}
> > +
> > +# If there is a configuration file, source it
> > +if [[ -f $net_forwarding_dir/../../drivers/net/net.config ]]; then
> > +	source "$net_forwarding_dir/../../drivers/net/net.config"
> > +fi
> 
> This is going to impact all tests though, not just those that are meant
> to work with this. If I have this file, it sets NETIF, and all my
> forwarding tests (presumably) break, because NETIFS doesn't get
> configured correctly.
> 
> The requirements for driver tests are different from forwarding tests.
> In particular, interfaces do not belong to driver tests, the test can't
> bring them up or down, reassign addresses etc., merely to use them for
> traffic. (Which you know, I'm just stating it for context.) So I think
> there needs to be an opt-in variable for this stuff. Like setting
> DRIVER_TEST_CONFORMANT=yes before sourcing the library or whatever.

I had this kind of approach initially but thought that it might be
desirable to also maintain the possibility to run the driver tests as
./test.sh eth0 eth1 as before, so I changed it.
I can move back to that approach.

> 
> Then NETIF ceases to be a tell and becomes an environment requirement
> for check_env to validate like the others.
> 
> (Another alternative is to extract a common core from lib.sh and have
> both lib.sh and net/driver/lib.sh use that. But that's more of a change
> and I'm not even sure it's the right way to slice it.)
> 
> > +# In case NETIF is specified, then the test expects to pass the arguments
> > +# through the variables specified in drivers/net/README.rst file. If not,
> > +# fallback on parsing the script arguments for interface names.
> > +if [[ -v NETIF ]]; then
> > +	if (( NUM_NETIFS > 2)); then
> > +		echo "SKIP: NETIF defined and NUM_NETIFS is bigger than 2"
> > +		exit "$ksft_skip"
> > +	fi
> > +
> > +	check_env
> > +
> > +	# Populate the NETIF and TARGETS arrays automatically based on the
> > +	# environment variables
> > +	unset NETIFS
> > +	declare -A NETIFS
> > +
> > +	NETIFS[p1]="$NETIF"
> > +	TARGETS[$NETIF]="local:"
> > +
> > +	# Locate the name of the remote interface
> > +	if [[ -v REMOTE_V4 ]]; then
> > +		remote_netif=$(CUR_TARGET="$REMOTE_TYPE:$REMOTE_ARGS" get_ifname_by_ip "$REMOTE_V4")
> > +	else
> > +		remote_netif=$(CUR_TARGET="$REMOTE_TYPE:$REMOTE_ARGS" get_ifname_by_ip "$REMOTE_V6")
> > +	fi
> > +	if [[ ! -n "$remote_netif" ]]; then
> > +		echo "SKIP: cannot find remote interface"
> > +		exit "$ksft_skip"
> > +	fi
> 
> This should check that $NETIF != $remote_netif.

Ok.

