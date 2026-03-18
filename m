Return-Path: <netdev+bounces-269008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKdeEdCeumkkZwIAu9opvQ
	(envelope-from <netdev+bounces-269008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:47:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDCF2BBC8B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A3C53035E3B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2812217993;
	Wed, 18 Mar 2026 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FJ5xra3V"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A26F280329;
	Wed, 18 Mar 2026 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837957; cv=fail; b=HvY7BxaVLpcOdec6VxxmcuksPpmlvCN6smo8N1CTF7VWnvzT7SlNkIuCodbBHNAzAlyGy4GTWQNKNCjMPbcXSfmrBd1dMNfoT/XNwyrloDUXhhendSy81nzKaZPulf/yrZdT3kN1bGm6NOLIFd2cUP0u+8R9rhMOBxRalM222x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837957; c=relaxed/simple;
	bh=oRZ8A1dCPR63RIc4rJOGeUaHetD5ZpD3z2/MID1Huwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u2JeJSFU1RHhGpl2ehG8awcKqjn5PtyUYnXjbXJebq63h6ukavslv0uxpphxOK4T4bgWVtvyLA8dfSaixMI101BaXEv1fh70ks5Xx1Vzn8RjH6sSLyQojBvMRTSV6jghJnAsf2pqxXP8nhBlFUzSwnOcVfT0VnUHnQMh4yutTlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FJ5xra3V; arc=fail smtp.client-ip=52.101.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Woay9viV93a0PBYCyWitMsk5IxsxJXpDIdvWnhLgCNSomMJZS06Yu2mgr1jmKQV3lHmYVlOI4J219+xUTCI4x26dFS8cx+IPyqkBsSPBM43TYaj0ddIlOO/jsuRxPgg46vQy0jbYXdRBd6Py+nuQmR3QyHiVkbcxT/HA18WSGE52kPIhjh/43Mnu3kHYaKSHNZz4S9vz1EpKaiBNyFYUCd4jjM9sRWavfnpp+GBzvwHsX04gGyUPTJmGbqzEwcD6FoIlVOt8Qi2d0CA3yWczi2MUq9zTBCZ1zG1PchChFoISGRddgvRmHINTmG+vWQpYiXhxGIyFxIdmt1Edly6WsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qELCmk9d/z24nsw78C/xNjybB9wMsbiTtmVxYiv2JeE=;
 b=DKiZ+1iUZBm6WZrbCXDqPkD4LvJOQSkycxMXyWpMVq74rJmp5Nc56E6bjzpguKAPi9/6pcyHsPZXTWvYKBc4JISDB9bALPxx01rXR38Pqrls+2wKG6Ed1pxBeEhEv0J5pahHgcxa3eyOb1vPjuRc1jOUlea3Z0WbWEqY3xO4NXYN8aqypN2yH9RWyc2RSgGEjK2keHZxwhsbaCYN19aT73SvxrYXq3wB3T9WWG2+EM09r4MqIge7FeXaty3pzSrQDWgK4644qdnkIQg7qFToLk2UOK+kXNhV6GnXMZc2ewbnXgwf23wLBkMW6WO+0PPFnWtZWf0BiD9xPdoW3mOmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qELCmk9d/z24nsw78C/xNjybB9wMsbiTtmVxYiv2JeE=;
 b=FJ5xra3V3RbTuuqFQTgIJLKK8E28vq5lo7bTDpHM5dXDBXV1NCEHBqTlMV1rSvT2eUF6fNNgeCz/3foEG7tYQhw0dUZYMhvLKBubeKhp2aNnfFSwk3g7A31wN2My8c/jpZ4ZkFGiZP6M8b8uJhOqENamifCyjOm1hLSHWF9xv/GLVQy/fixGtot12Ng6/6XUghwAa9s5YRCR4UPtVmo/eEWKvG1P+SKwVRoE8SE7lu+IQ08MH/Izmf7r4aOIZXg+yXJ58Aub3BXtpNytGeFuTP4zqBwbJqzXy1puq52ROEMJfNrOL1UTj+Z5MmpGrWL4IyXnO2R4Dpf94NnsJ134nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 12:45:49 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 12:45:49 +0000
Date: Wed, 18 Mar 2026 14:45:39 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org,
	Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10 net-next v3] ipv6: prepare headers for ipv6_stub
 removal
Message-ID: <20260318124539.GA3693409@shredder>
References: <20260317140141.5723-1-fmancera@suse.de>
 <20260317140141.5723-5-fmancera@suse.de>
 <20260317201236.GA3581148@shredder>
 <f67f32ef-d619-4f61-9054-e6b6340129ad@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f67f32ef-d619-4f61-9054-e6b6340129ad@suse.de>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0e9a75-9690-4efb-3bc7-08de84ec485b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B/61wcpCnwpPGC/yg5DIZOgHD86b53mBiEYEbv11YIqAx64eITM+XBS4BojFNV/OtWKWvovY0doa3FTMlpwx2rj4xhsBQemZVxtWJ1VO67jQgmQiB90ILRA7fLAApEDfNXFsb26MaU8ws2X3yOkyFGOUNitrgP4ogcn/FHL+cu8MiCG9m3OAJYftsMf93VOy7NqTsG7wFyHlytj6p6SgcHjz1UnoLRo83XkVmAPwKDy3XcK5T/CXPhMGwAEKVunUpD/xlo1qJIn9qNFv9v4jX+8xUQmBT9N3dK05kdn8f6OAiVsZUuhe9Opme1t/OJ93QncYsqVw1PJPL1RiaLcwUZ8yP9cSu5jKAgNQ8FHS1NBfyFpUpvg8goij150/A2koeGwhTwcO8yvF3kIhJ6oluGTuDyp8fdsn3t9VClKTBmn3ba6xGlbNZiFwo4GNeq+BqOK5ZS5BsgmZbB5mRvHzvoem8doEWZRi3kpbS66YplEIcsQe19eVNCYNHZu3phhyiFzrneZyyhixkWO+hUH9O2NKJx9++D+FGrPepUT76oMcu0LgZt4Yhrod/8c2Iw2QGjOqf8gYl9xkAsa2PxS8Lhr7bM/TlTKgeW6nSfxMm3ppnAEoc/IqytLSorcu4s7x8+YcHW0K/pV0YVOs1909hWBelxfFkMNyhDv+ZVYOldzxJ7UW+kfrNFbXh5cAKt9RuzaYkQ/R5fQ63NTSNVcdpo8UwXfaIhIqyIhQvMfrcXM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4AFbfn+NAAGf+nRT+w0N7UelmuG13057sJfeTe4HjgtjMljmjtubycJc8Itg?=
 =?us-ascii?Q?t7SgJFvaRMw184P6qmauL97t1OxaSamClEAPHU3QUE33cQOkKcYpEGqGtvc6?=
 =?us-ascii?Q?Tbw/Q48/cHNoqrs0mlnX0zi6Bq24KjzGiJ1+9T8RcaRGNx8GrVEWAj8R5Cig?=
 =?us-ascii?Q?pu/CBBgEXXckJDP7IayM+shjNTJ/eA7wZAUm/ngTnpN04isvFFaTVnWDlLw7?=
 =?us-ascii?Q?rWijGZcG0ueD2QXFSccC1/v/nhvtAVSxhQysKm0GG1amKp2EfrdOIv/TOtkU?=
 =?us-ascii?Q?2VSDdv6J6SSHKZwHgggm/a70JKBv5w30p4CRZeYfGdfl4lURLFO0eDXuNXdP?=
 =?us-ascii?Q?hA2cb5WLdSDk4II1n4Aqq6mU4TH0JYQxREbBnPF+HziaLVE+RjjuzilnzIHK?=
 =?us-ascii?Q?y3zU4cPUGPJYihRhNt0meJ5cm5E/Mzrrck9o2Wq3m/XoK9BtLjcShPqPvr8t?=
 =?us-ascii?Q?lwzWSvql80P3t0UEbCJmvM1qmymiz95MV2LV0mbEnT3BYynISJVGcrGyOLrI?=
 =?us-ascii?Q?c1VONyPPFnrD6l0J8b8mdzLAh70v0Y5e5KacfLNaRyI9APZ0MZEtjs6TYwJH?=
 =?us-ascii?Q?kEvDeYV3dPCEzc1RmekgMc8doVXHtqTPZdKzQGRWO/kazlmpY9+H3OEphXwx?=
 =?us-ascii?Q?AMSH0HdCVVsp901x8+LhV6ReS3gX/5kV0zSzQAnqy2JqFEIPEDjUfoIzpJiv?=
 =?us-ascii?Q?NlKXmG7PSlD1nJw8gdKcoCbmvzDPv7N3+jwJTW1FML8PzAzHcvCNzehtUFkM?=
 =?us-ascii?Q?+k/Gh06wJwZjyOzCJTklsQVAf5kJDPnadlsp2dpVkppzCqcHuqD0Gh454beR?=
 =?us-ascii?Q?RN2UhgQLKxtWTsTP1Itg1bGNlqBe4cU7mZv7tMt/gU1AzqSiREv8JbpBXefO?=
 =?us-ascii?Q?xFm25BWb4Z8hamBMEGJ0whl5qat5RpB3UlPbBGHHreoZ6UEgZqXRBQBWFWcw?=
 =?us-ascii?Q?rQZBIOG7eOpsmfynXgF6uNkgS1ynyrA9uVzmGt0QQoTQABBnSyxN7qgE8YXm?=
 =?us-ascii?Q?gJwPsruVXdgP5+VjVFc7VUM7E6Vm0day0qky7u2wpMUjjjSL9fpu/9h20xBl?=
 =?us-ascii?Q?9GEOl7zZfyG5hlx/lvjkOlMHxcN0qIwAhud1xUFv2GP0xzloaVlSjTEyWa3P?=
 =?us-ascii?Q?bJKjRw1kde5uyH4rIDmWL11WdikYnmq/ivSqTwwSkfZTdQRiaRMAEQVaHxTF?=
 =?us-ascii?Q?l0AaLczagsuXzY3HYwrK+IJm5yp3DJ/B5lUnDQDi5WebI5GL8Rf25SBfZWoG?=
 =?us-ascii?Q?LvKXotOWtRzclqgdLGclArBvKo+BVXYX6Xc+yrtRIGp6q3lCjhMHPLKF17v7?=
 =?us-ascii?Q?DeaH60vbwtrmCQpF8fRvWXCjdsAZwn0QuD0alg7WBMtW3QxVjuRcBMU/1+xa?=
 =?us-ascii?Q?b7hT2oPN+hF/XmmBQpFASL5i2ONyYdRqwTKwaBDQHqno+vPFVthjVuCWX59e?=
 =?us-ascii?Q?j9ZS3DQ9dP7rgbYnEiKZectLDEBpMrT3ZRO/dQmRX5TO5AQd5huXKlTb3Gol?=
 =?us-ascii?Q?SgyCOXGgQHKJtfqaSNCZcdfdKh7aTxq52CW8mhKlZJm81hw1BKaMbHD9WJp6?=
 =?us-ascii?Q?zEWmXN+12oPhDaLfwXhUGEq9QYTq7MRzCm1GgrVBFCmQP/r9noRpW5Udu+1i?=
 =?us-ascii?Q?IutZj8L54fOgIkKMyqSnl+21Z6HF/IrpHoyadXr2OFYDX6mK3mOvmGg/JRL2?=
 =?us-ascii?Q?QIdRqkgaftwLInqzr3MQwkrQWNQgFcDyiE7+h9j/g8buJJa96nacr3IDGHYe?=
 =?us-ascii?Q?Wkg9hRFdBQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0e9a75-9690-4efb-3bc7-08de84ec485b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:45:49.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/OwBrIVBk/GjZqOb1+zX8Da2D4UqRccY0WsuavT3Qrc6XDeyXNRdi2qygyT/mjEQO6f/dpZAYpJ8mOqmGxIVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269008-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDDCF2BBC8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 11:43:40AM +0100, Fernando Fernandez Mancera wrote:
> On 3/17/26 9:12 PM, Ido Schimmel wrote:
> > On Tue, Mar 17, 2026 at 03:01:00PM +0100, Fernando Fernandez Mancera wrote:
> > > diff --git a/include/net/ndisc.h b/include/net/ndisc.h
> > > index d38783a2ce57..6152401f29f1 100644
> > > --- a/include/net/ndisc.h
> > > +++ b/include/net/ndisc.h
> > > @@ -69,6 +69,12 @@ struct prefix_info;
> > >   extern struct neigh_table nd_tbl;
> > > +#if IS_ENABLED(CONFIG_IPV6)
> > > +#define ipv6_get_nd_tbl() (&nd_tbl)
> > > +#else
> > > +#define ipv6_get_nd_tbl() NULL
> > > +#endif
> > 
> > What is the reason for converting code that is dependent on CONFIG_IPV6
> > to use ipv6_get_nd_tbl()?
> 
> I did it mainly for consistency. If you think this isn't fine, I can move it
> back to &nd_tbl directly.

It creates a lot of unnecessary churn throughout the series, so I
wouldn't change code that is currently using '&nd_tbl'. I would also
change 'ipv6_stub->nd_tbl' to '&nd_tbl' if the code is guarded by
IS_ENABLED(CONFIG_IPV6), which is most users.

