Return-Path: <netdev+bounces-269908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBYmILRDvWlq8QIAu9opvQ
	(envelope-from <netdev+bounces-269908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 13:55:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 225492DA903
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 13:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 851D2301252D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCEE3B3C12;
	Fri, 20 Mar 2026 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oEIELUYJ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22636194A6C;
	Fri, 20 Mar 2026 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011314; cv=fail; b=uUtmI2sZJ1+4a1nRL2T6I1J/k+5RyLDHY2D4F7ghRulR/nt6OZffGMTtnNPiOUUfXsDjhdxquQP9nQelgmYqivMaPfku7iu4YkYItAq9gi25xlEsHYrwgXRz6Qpa/Ogyck/8XbU8Fjr1HwvuxdkgaiuaEQK+hpbYymI1hYNzv1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011314; c=relaxed/simple;
	bh=uh2BhX1wbmPnyxEBa7bxDIzcMdOvP5JgjsfjFaaIWSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oWMd7N/1+g5u7W2TO92AmZh5nqV1tPfcUPjJv0G5XJEj7uORazDsD4x9EoK1Cfsk25RznZY2YnhlUIBwt3WQibtflNLU1ZUUTIbd6yY10fA+xO08x6qAxvwFsS2dUx1tP7vTTBcLaPc6zpkU30xS6VX2eefsbNutuqXONuuFyx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oEIELUYJ; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvO5+8V9leiLbMz50Xob/1woDrtT0WzupIBCWFwjudotujkhLHTKRQZdGlaftJ4qCbH02ZLwUUn9cSXTI9Umbm6ZJYcPaLud9w9KS6AXLRno7w/tRBisTf8zQQRQYFwuZdLK6tUZvMFVANlVO6WZlKTVj6Qpz3o99O35t15gBXd4rNm1nPBNDru5bBJkf28WfkMoZxxIqESodYoKNxJ5NOuVath8HEOWP+qAWxLUX2GIDLHFdwon0fiaFVIWbUCjYeI7ZncNa3vdDTJBMr2Htm445RV/2WvO1Z+3R1C6qV1uUoiA8+MJUF++Rg1NK9BvOKgISQurdrGqTQQjJMT0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBMYPQv6a1E6rfWvAiPrwdoM9l1FqY8lJzII5W9+VaY=;
 b=DIH8z9f1TSV+0PYimP2caqFQilq6b471WkcH97nWJh4HhUdSFzAaB6NIjvtPFW8B1Wq3718krySXw0phVA8FT5/9zRfEBEVBptunHUXN19F37Fi3B2zI3lbVT68166jt4vZZqvY/oeQm8XTdxSjxiaCgL8kPdZJT3FMYKSokFnOn7Wu8eBRgX6dMKRSz3QUVHUJzwCM0OEP768VIKfEQCVPnQzSYZRooCep0Ta0jQDbUjOvGOejtUM+dP+p6zWojliehbG2/Mhsig9aSBInEFw4VEq5Zoh9l+9ONW7Zblx2c5aZkG+5ZT8HPwimBa+Emf8/kL2G/cdb+SaEoJdmZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBMYPQv6a1E6rfWvAiPrwdoM9l1FqY8lJzII5W9+VaY=;
 b=oEIELUYJkl2ICAOKbfRhyiL8rGlQ2EPBPeQLGY5f2wkHyYiqLmiZYrA5Gp6i89ECNfDyNfJLN7dvICCC7JfektlX6olIHOdl453H017FJWL23KafgETDvAFV6fkiIsOvQQ5/DTLNRlWRSl/Cs+XwiRS2jsWwKxFLOoMP+1PINh1uNdCiiAahqZFutBS65iG/+mar4rcI9aeYyeDlqUP840VAVfmAV8paf8IkrV5NM3kHHg4vfTDzH1fJh0oggl48ZcjkpnSoEjOsWx8VSmSmq4lSPmKjgzuuDvrqJSnCKLLoUp/YfqMwc7A7NSs+ZiT3s+x7dMNqUINaxdu3YRxQUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB8115.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Fri, 20 Mar
 2026 12:55:02 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 12:55:10 +0000
Date: Fri, 20 Mar 2026 14:55:05 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, willemb@google.com
Subject: Re: [PATCH net-next v3 4/9] selftests: net: update some helpers to
 use run_on
Message-ID: <urkiiiyhbk43msxdkm6dnbjgyhthu2rxgso7wkid5hvvun5m4a@mlmzekjt3wnj>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-5-ioana.ciornei@nxp.com>
 <87pl4y922n.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pl4y922n.fsf@nvidia.com>
X-ClientProxiedBy: FR4P281CA0356.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::20) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fb8e16-94c7-46d4-da6a-08de867fead6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KfEvpf8RlMet4zQFINifnEdYlq6YhSffAnzVixE7lqWa/m9tchYAIgEUt10c+lc24hw1UZOt6/XpCq75hXzlxzTmrPD1F4c2m8hROx+IRh6/8ydUBsVDyHiNIQ8TfWJOrPxN3ayPu8RBhl2c6nSrk64xnMyxE3pVu26L7+Ccn1qH/dWXdVW1kk511MRi4BFWNaHuIEO5u/g1pukYdWd3QSVKyTKKUjEQSoHRLA/Q/ty57FOeQJ4RAZZwmicg1mQAzkAvK3441D83uZ7WjtQjDM1/XvfdHbv8+eHZ76xnPLuP6q3pz+7YcL1YbO3EF4OWOsWdIb4mjNyszOMSD9RztAjVWhQVyNinoOx2fnW8p9u4NgKyij0TPYvAdwqLKTylhMBy+U0aNrhRmxBTYOioDFPoGpGgzsQHud8uOn2crxyikQKUBQL2VkCicDRI+iLOSuS48/N9HRzSEeCBPua+5UCQo1ic7BmIx4JAB4Dllf2J1dXfr+/wSP3OXf8RC/8aLC6Z9Qul294Al0Bbgq9V7ot1oASZWLpakWg7sFldiLX2BQmrwA5RPfGIHe+vESuGEaFtBpiA7VEPNV+0O5Ux/qTeSEb5quaHQXDJsy3NyO6UOis0IPNbEavWEgUiJTNdtYYooOe/09dbKzfahKu3+i3BocRoo24L+RfzI2ShI6ZECb3LQdE+TIu5Zg4XVirlciZ56LhZRPvZLaYgs/8rdhzs/OrXcJvaoc9j5UAbHTg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a2cH+0W0G9QU8T18RlIZ5OLNJu9hZm1+c7B5iqBQAucJsM7Wkbq3bwpQUcRe?=
 =?us-ascii?Q?V80Zg4iVouOPLe9WoJ7LRSTbyK6NpImC4KcDYkQCLWU1ErzGAiEdFcZF/vtd?=
 =?us-ascii?Q?x4ySJ5XvhNMuvmUPy25touDgIWMCPJb+kx1iBsbdNnIHJ/+GlhG18FIysYoJ?=
 =?us-ascii?Q?jyycRm7pwqOs0xZWbnO4rUhhKrb9/dWBGU4i5dRC4wCJHt01eQ89ERq1QBaA?=
 =?us-ascii?Q?+uzw3XF/ilju0xlB+Wsy3iMksWlPsc5+Tnmmw7Uiejg09tfztzwYKUmk5/j5?=
 =?us-ascii?Q?cSwmSOxTCbo3LFAfjKgrtkqnKUuUG0THCqrd3GflTNEoSjqvFkA9gx8aTJLm?=
 =?us-ascii?Q?FkHVOsWEouXFrpFWDItva2JJa6piKD1DjSu/oVZzEStZn7tmFDxQYIxGCiO/?=
 =?us-ascii?Q?/OQxACPqrSPbr41xq3H7RRzGcQuHO88ESQ+bIBhFz3HBRxgkBiojnudq3ZMP?=
 =?us-ascii?Q?JOKdQNDwcQnAuWs9/QuNXSdOhB+H8XWC/6WY7YmsYZd8p2Qzn80XIDvSdGZi?=
 =?us-ascii?Q?L+cLoQCNVkp2RcS4sfSVbVxk+Q3txjCCzVH7RKdpLElcszYtMwQsaFPhY504?=
 =?us-ascii?Q?Oe3qEVAYzjdhulHi0wKQGjBBcFtD41MIi+LLWpoSKYDjjYZOEDwfcE2LT3oa?=
 =?us-ascii?Q?WkNIz+GhbZTupNRyanoljZL43vv1jWANUNG25lH+was1h/lNrArqg/mMLs3m?=
 =?us-ascii?Q?p8/hNX2WWR3Ri3DtSNIcmXQFAeFwMMkrXTNaS160ZY1PKXiULxhW36uzHB85?=
 =?us-ascii?Q?lT99KQ2WZrIgcgSo8bpn6xfmjI8C4FBbxxKNYyK3VKYo8IQNEP0VKEtVKjbg?=
 =?us-ascii?Q?79iSyszcLwB+V8xDgenFdlP6IOJV+NueUMZE66ortigpAOXme/Opl2bxiwb8?=
 =?us-ascii?Q?VoW3gqEb/QPM77DC3Z0LFR4TYgdU92GQ/c16Zmp3LhxCf5OIAk5DTrjwFmKv?=
 =?us-ascii?Q?S5ITtMMQ6ijLf8UmT9ricNazRZbBqqH9L/1ZtZNUsfXfc+sR2y+8F6iFGDsj?=
 =?us-ascii?Q?B7c9ldtgz+95EQConsiUJ4fXISMANppBLLb6YE7/lrbfLdQAmQO10OayDusC?=
 =?us-ascii?Q?fqKF+Me/lcG1rZUFV8IZqb4vFopUt6IhiLqu4sFfXy/5878Y0fyTbuBue6Ct?=
 =?us-ascii?Q?Y0QFAb5ZeXBbK/PWrXgZUxyFTdm9BoX1+2n/QLcwTvllyttMlC/7E4/1d85y?=
 =?us-ascii?Q?FavrudybDdhoRVI1R9RxliUqvwakh0PR1fs/edDgzsaFhZkvt4pue6Hsjilu?=
 =?us-ascii?Q?MLLayAZK4duXeRaEXBaYCN6Y4p/uFmZPmM5hYo311MeIlTVVJmXCRLzKzvFD?=
 =?us-ascii?Q?76kD/ktIr2NIWbdyFTBnb7dF0/tCpv9gHHl8X3SL8kCK0ZP1JgiZQwaLrduS?=
 =?us-ascii?Q?84Pf5z6jip5pLxNslkXPpJTZK8LRJ5n5d1cAGJa7AmSc66CYGxfGLbevAYs+?=
 =?us-ascii?Q?Se5N2tJJtYwVU/4CB+qFoJJnXfZtmndHTlgHuU64k3toAeFZG1HfmwKCMlKw?=
 =?us-ascii?Q?4ufeMj9uwiJduFWhUXtzJuEwIFgrRrdgRHckwWy/QY4n+UtOUHA57+0XT3wl?=
 =?us-ascii?Q?/lv7ZZbxHGrs/gXJTzr5viRbZ/OVpJHsGdX+6Ra5+Bn8Ubo8H7UdFdTJ3p0O?=
 =?us-ascii?Q?QaVOpDAAFUjC9Yindx6fah36SUa8R+KW+8rmHNDFIM7zz30A3cUV0w8Btbbr?=
 =?us-ascii?Q?psR0RY/gkOhHOxTAiSiXlSYvwAkqFJfQImWHtXnE+z6BJww5p0Z3w8Cvwl05?=
 =?us-ascii?Q?k5/Q395+VA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fb8e16-94c7-46d4-da6a-08de867fead6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:55:10.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVvZBCX5MsSd9VeC1TLv8qpFpLJvWiWi+geUvyD0wH0hJqRjapw3Fj03n/GKldWUw4KW/MR+08V8cdy2HbPLrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8115
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269908-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.961];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ethtool_rmon.sh:url]
X-Rspamd-Queue-Id: 225492DA903
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:22:02PM +0100, Petr Machata wrote:
> 
> Ioana Ciornei <ioana.ciornei@nxp.com> writes:
> 
> > Update some helpers so that they are capable to run commands on
> > different targets than the local one. This patch makes the necesasy
> > modification for those helpers / sections of code which are needed for
> > the ethtool_rmon.sh test that will be converted in the next patches.
> >
> > For example, mac_addr_prepare() and mac_addr_restore() used when
> > STABLE_MAC_ADDRS=yes need to ensure stable MAC addresses on interfaces
> > located even in other namespaces. In order to do that, append the 'ip
> > link' commands with a 'run_on $dev' tag.
> >
> > The same run_on is necessary also when verifying if all the interfaces
> > listed in NETIFS are indeed available.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> 
> This looks good, but I'm unhappy with some overlong lines again :)

Sure, I will take care of them.

