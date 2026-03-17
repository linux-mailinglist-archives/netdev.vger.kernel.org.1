Return-Path: <netdev+bounces-268484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEBsNhcOuWk/ngEAu9opvQ
	(envelope-from <netdev+bounces-268484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:17:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BDA2A5686
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DAF230062E2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7156B33688B;
	Tue, 17 Mar 2026 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cm9rDTY8"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20905188596;
	Tue, 17 Mar 2026 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735445; cv=fail; b=jH8ueBPHNUCqQhd75SdmNDvQmwRAOvCG4rgS2/B7kyS7S0kfn6SCEc2EytWwC94zOKYNYiFtDabzs6bnRV6HYGhfqO6/12E2y+PNj3uS+81D2JSlrH0W/ygkmcx4l0Tc3dwJni5AVJpY63p+1Zz9ywIH8s+xnVM0xKVEt//EGFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735445; c=relaxed/simple;
	bh=poftu3NblEj3runtLJkpuSnrq1AH9GVP8A83h1/4B4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L8N+pZVhIZN+nI77k7gjKfzzcJcqD//BOd67VQZBx8k8uZYNuZ5/B752/XWDJ3BIh44FxUDwnfjKXv82efSDWrBq26l8i7/g/2P4De6d8+rMLTwXkmLz2403goi3HKWwTZrXU7mDWsb0rxjWooUl7ZLVhmunLCktha7Fk9EhkDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cm9rDTY8; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+TGf+GXZD56rV9TKUBslLpp2cR2ygEtvgA0zjE6DOZ/LiSKkjoWiOIBcBWirPNFxp3XM3S2y0rpLw5+J0ifTxNlXLFdG+WBnGyDt3WThhymIAIQ+IZ1whd2+tc51m9vEDWmmu4DEMB/S4nH9EbjYJzLXjoPTt4tnsBqMoTeT5uUqdy3mjaRJaWFEFbC09GFtu6oZnhpYk6zQjJaZ6k2MZ8k2SoC9AUBW8c0jhQwG0/uiEg79JhDLqC6CORjZcR92iswB3FkSdo4CW/Q1YBr/1x/icpVtwYSVG3aZE/Yl14KZaLh79dIMgV0Z+Ows+NkPcv1r5waUui+RVf75lQEPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd7dPrUXupQO6aypppA+UNieLj3hr0qe7nQ23gewTgY=;
 b=XhW/EaQNssrg+9EYTNOybPgq08Stxc6tW5O/FAebARYDoAYdJ4xmJcP8etXUTO1Q/85NcCppxp3dCK/E+NAGqmqKn82NGyQTmNzfDgVgMfebKOqSd9oeCvw+lp+9QJjyaVvQ8AjjsWmnTDnrQgk3Ymm1DoPmOBuUcpH+UvFvgdOe7jW4e7YiBkdp1ouyAnnTMwl5h/2LEMuJ7ejlitmMsxX7f7c9Mac3poC8i1E9uE+09gaommVTqdjsP023lJgwJgJZcyI0PKxsJkTDl4o6UXpHNee3iT3eLP/JL/EGPGrMezar1B/HXhF5UQ/6Yj5NaAfFQsteAsY6eozvR9Ms9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd7dPrUXupQO6aypppA+UNieLj3hr0qe7nQ23gewTgY=;
 b=Cm9rDTY8FJWR2jnUE80/Hdf7Rt7l8YSgSrWldzeyU43SsoqR+RGrG3uu2f3Sx6/RCqqIM9ogwIJtw/hHCp0hxo0aR4M4mDzxwem3hS7XRSyq42/iaAy4SqkAly45IVS5MPuyrX9VC5SD+Ca3nLVTbwj5+kSIar1N1yoZQ3cCcXMKT2/1d5SlvfbMGIhiSTaCfGkW3/IJEu+2khHA8XcXsWEFSvYEalP5SWhLKTB+Deg2k40q/vS6hz15Df6tzRai7ijRB4EBy2uPso41nhEJIKswuDAmojbG++RXzBf4OAVrI/LuO2tyroOq6j4QW7t4wX7tGjZ78chLlONWkX9XPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by DB9PR04MB11627.eurprd04.prod.outlook.com (2603:10a6:10:60c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 08:16:53 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 08:16:50 +0000
Date: Tue, 17 Mar 2026 10:17:16 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: dpaa2-mac: extend APIs related to
 statistics
Message-ID: <fzotzgpkatulggt3l63h5abmaz3fmavsjtpco5mc5wuxuw3vsc@k2xkvbp4a6ik>
References: <20260312142249.297192-1-ioana.ciornei@nxp.com>
 <20260312142249.297192-2-ioana.ciornei@nxp.com>
 <20260316203939.7629aebf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316203939.7629aebf@kernel.org>
X-ClientProxiedBy: AS4P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::11) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|DB9PR04MB11627:EE_
X-MS-Office365-Filtering-Correlation-Id: 318ec593-7e97-4002-48af-08de83fd8a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BTo22wKDVj9sMtF+TmgB4D6uIubX9TF4sYkUHsQjH29Fl7Sdat8ILCOTH34iBka3F1BZzWkqlgtWN+JSUUhPn3/IfFYDlP+EzkhjaBXh4BY8Rma+7VN2uJB8nymOkKyLxA7ZY+JS+AEsQWIB4ip/5TLd0cOynDEc0YIEJPMW7FAsdz9GtFwXA9K1skZSdRA1BK6jUVI7RdTShhLW1o8CACHMeRmfhx163i7Pzc0cDW/moWAr2/qTWzllq/+xFtFg2/ra8bF5lA06THQcrSYchsqY5tcA+Ku7wlQvR9B/3Q7ACp7OIfUDN6LR4cYNLSQm4XzZ8pyD/XEjtYWdtTOYCQFq6UVQyWThLHsjaecqJ2YTZWpBu+erylgyGDVQzsG/JjyDrSGiq/gcBly6b3vsZclnhQORNnBxCgDPlOxkj7P/2vDXUWBvbix8S73J/eHBsviPfPmUFJlxYJSQpagQa02IV7HuaXgahX5HkeNynS9yfKHZuuJRF90ySfwArmSDeoHfBvLZ+Rn8MfNcmh2MkSoXORsXZ5QgpjVDF8rY/POfUpNxxKdzV9I10Dih4m82vAIum8b0L3DxPXsl5E+S/H0c6mA+xF5cQxhyefrn1VXDqG0bWEt9yeRlFmLCcKoeT4On/W8SBztCCj4rOfemBPPsu4IYpzu/2bHEYx5k/g5XYQ/vJItnMzI58drbZAesXo6btXC0DcRM/+duqrosyhyYmb7vQw7OUEwz9GWp1Xc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uv0gLLy66yPL9zrlhHHaUvQJrtsbV6Tj+2uwh34fEa8g2bKOJLSTwal7iI8o?=
 =?us-ascii?Q?EV/TaZrrX0HiEwsb35tDa2RVA0Co/4qbtOWmSN+wIm6jA6tKzyzZyh2QBpZI?=
 =?us-ascii?Q?jf+NayEqIp8DuNhdpIm6tNk6HQfHp//mVSDdXBYtQXu6ZIgx0kmX3GFMVVRC?=
 =?us-ascii?Q?F1HYE78CffYxur2qz8iek2TaHOI3e+QM6/XsL+7dtz3LGkBI4ZY6YigFner8?=
 =?us-ascii?Q?1n+OU5vg/Xz6mSmM0G3elv8ly1izV6ifTvuqQDb+kn1Og1H5R9UJUTHeICel?=
 =?us-ascii?Q?RDH5PuJu7oPdQzwJbsFFEiQTdhLOT3O+g3pvmvlRP33qUwT8F/uXmBuKZEfu?=
 =?us-ascii?Q?krmK2VG3uZC1g4qhGlJip0S+1jASVI/6ss1/UZeQ12lOuzWe9JeqIAvw6GuQ?=
 =?us-ascii?Q?G9qh0/VXc0Zx34sI4sJejysLvZYH2M+cHF1pWc8vNFAbzKIjrlIRc8a5BxUP?=
 =?us-ascii?Q?SoRl3tkwcmhAEvqRGIyHabq6nb/oonjxu6wM12LsYrRD42RgSme+mNIZ2nL4?=
 =?us-ascii?Q?Qlk1zL1oe85FVB3epxrYDCaS0WpplOg0PLx+iqHhV7f6qneYmq6qSZD5eE11?=
 =?us-ascii?Q?RFIJGZ9oPvGWd57N12V+SCfe+r6setVr4xRuQWjdiKP2o9o1g5o9aH1QpyVN?=
 =?us-ascii?Q?hmdiG958EDVCtu7GwB/R61CYr7uiqdwIpxwBAFR8fW/T0iGSEEoN3ZV2qCgg?=
 =?us-ascii?Q?UjzZdAYFmVvnbcdrUeXBH+uofLK8qH/dQ1T+4Z0glJvRlawqOGlwCN+pwlT2?=
 =?us-ascii?Q?w1MJOa2m4VHtMC6pJNwSEiVHlDJPhHWvv1IK3uzugPTIuAIg3s+pPRulBtye?=
 =?us-ascii?Q?02OajbFb3/bkWszhMfVjpBRJKsFYs+n5gg3aND83W0n9wgM2+p8B7pk8IwHN?=
 =?us-ascii?Q?FANecc/TXSk5dW40yZWmO+Keg3gMQaKCncF6QvnfPxVN4Ir2e+8fvgmskhQf?=
 =?us-ascii?Q?4xJutDlg9DyVM20z59qnmbrZvH34zRJ31PsVNGT0TVOWzuu1cBhqOASCev2J?=
 =?us-ascii?Q?5Glhkk5bVeumEdD5Gw5ycG3Ay4COscSlRxaVjh2RI8oVJHCkKk781ZUtvyJd?=
 =?us-ascii?Q?TVsBSRZMdyIu9z7PQGXOkWal1F0eht56frgVKUgs17Apv7Ue/nOCpRquSBKK?=
 =?us-ascii?Q?TSOmTDDLbzvY/iobiIs8M5ncbyushrx0cU+8VMHZkwmRpRFkqGzav9EWsIs6?=
 =?us-ascii?Q?6tLEj1Wf0urow90yDIk4roZ3GmXI6ZLRlSzzYfvdUKhpKDT+GaDCJFXV+t6t?=
 =?us-ascii?Q?hReRYoDuU2AjFbJnXivlYqKd/pc50L7j0JcuJnSInHA0GmjIIvvxXRLkQUKK?=
 =?us-ascii?Q?yfqz3NRcHZPMZFOQivd3onx/JbtxzgJd7+PGCp6bUwDGLRhIWqNIueQIUx/B?=
 =?us-ascii?Q?DCcCHSz0SDc3cpY3/nnMFK99BSXkGv0h6KgKxJttoK7WfKSveMSv7SmBrc05?=
 =?us-ascii?Q?ObebtivtKzqhp7YaeK6udxXLEPV6pCRT/Bxom3uSBm+R5hAqnOy9yHdA3jdk?=
 =?us-ascii?Q?VrpYBpThShIYoR2zywpWr/t/5yS8YXiQ8f0cOPBKo0/Xf1RFXnMNmVdSEYvu?=
 =?us-ascii?Q?VarKx8kgGgqOoIycUF0VAXY/o2Qe5TrQND1i4RAHWyXDB0pIB2FHEvxjmQtL?=
 =?us-ascii?Q?E/2awr3dTyDhZAltUe6dc0QDR88UMWRemhObucjiRlemgk88kgegBRsB+K3V?=
 =?us-ascii?Q?l7hZouBIO0+H0AH/m4NEtDEBiJXT+3Nq7dQtVpxd3HGbD4jeXRUeZNOpo6gk?=
 =?us-ascii?Q?6AOLAax1dQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318ec593-7e97-4002-48af-08de83fd8a15
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:16:50.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mre84Pa8udeWj4CrGYJiWhJnrXaHvQLzRIG1Ec0Sh4Nraj3q7D9SBBHbp7ML8wtHXYqz31aPb+MK1+8ROdZN2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11627
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268484-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57BDA2A5686
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 08:39:39PM -0700, Jakub Kicinski wrote:
> On Thu, 12 Mar 2026 16:22:47 +0200 Ioana Ciornei wrote:
> > Extend the dpmac_counter_id enum with the newly added counters which can
> > be interrogated through the MC firmware. Also add the
> > dpmac_get_statistics() API which can be used to retrieve multiple MAC
> > counters through a single firmware command.
> 
> >  #ifndef __FSL_DPMAC_H
> >  #define __FSL_DPMAC_H
> > @@ -170,6 +170,50 @@ int dpmac_set_link_state(struct fsl_mc_io *mc_io,
> >   *			      pause frames.
> >   * @DPMAC_CNT_EGR_GOOD_FRAME: counts frames transmitted without error, including
> >   *			      pause frames.
> > + * @DPMAC_CNT_EGR_FRAME_64: counts transmitted 64-bytes frames, good or bad.
> > + * @DPMAC_CNT_EGR_FRAME_127: counts transmitted 65 to 127-bytes frames, good or bad.
> > + * @DPMAC_CNT_EGR_FRAME_255: counts transmitted 128 to 255-bytes frames, good or bad.
> > + * @DPMAC_CNT_EGR_FRAME_511: counts transmitted 256 to 511-bytes frames, good or bad.
> > + * @DPMAC_CNT_EGR_FRAME_1023: counts transmitted 512 to 1023-bytes frames, good or bad.
> > + * @DPMAC_CNT_EGR_FRAME_1518: counts transmitted 1024 to 1518-bytes frames, good or bad.
> 
> please try to wrap netdev code at 80 chars, especially if it's just
> comments where wrapping doesn't hurt readability.
> 
> > + * @DPMAC_CNT_EGR_FRAME_1519_MAX: counts transmitted 1519-bytes frames and
> > + * larger (up to max frame length specified), good or bad.
> 
> Other entries in this doc prefix the continuation lines..
>

Ok, I will wrap them to 80 chars and format them the same as the other
entries.

