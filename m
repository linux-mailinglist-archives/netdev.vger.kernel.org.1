Return-Path: <netdev+bounces-266778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIPIKincsWlPFwAAu9opvQ
	(envelope-from <netdev+bounces-266778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:18:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D8026A59E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFE2B300E4B3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 21:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA0344DAA;
	Wed, 11 Mar 2026 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eNeKhnfL"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA035F8B7
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263899; cv=fail; b=L1cSCrFITZVWD8MxMsIkkMuoqbajbjkmZtdb/O0sfj2tWd3WIj76cxz/bJmweb2lm2Tq9buyAX8eb4XNf0eIqXSMpwX/HLh4GObssODR0J7QCOFU/2yAdw43v0fNeamzdxpgAAtiYKJDxrzWdz8a+pRohHL+Q+fdA7GSCxzJ0w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263899; c=relaxed/simple;
	bh=gJZUAspAdL/zKQdsKUZLhbtfcho1xmDFj2GGtuL1xzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=akXTdFNyx/K209RZE5elB1mzojzbjIxGkWkM9z98UCpDvyPsigG/chxf+KoAKB585cMUQ5LLgvdEIPn+m2X/FmBXw4w4fMG6BcJLFnws7B/AO7zoUHyzZdTG7Ij7i3d9C/z2M9TLFtWahgc3CRppEhXL8DpaJaINYdIUexpfSnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eNeKhnfL; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bi3ihWUmIIlKAh6LxYiYZBSZG2V8AELVmkpKExaRrCQvWxJmsm/Yz4XfaFCCyCVWzvlZWNAKwO1LFc6aGnzhhZIR5uOtbo5zingFf2F8UTYVxiMx3QuhyFASKIf+Kdwltls6QBT6mjZb1IbdCcG+wxF8I+V/XDShl5dp7TaRwTgTAfjaLeQf4/SoVatJGN0Yx5H2+GKJx2EB+WhQsmJB+c2TCHCFCjhKYb8wuniBkiLBh6GsoUFDWEsCmArpnES1y/SsDBJJTjNJi+BYAxgpUBGlYcgl9TgywQC12FAZYEihWtffuLCHx/J7+wKyJt5qK8EOh0WHQlnsposZtOQ7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2unm6xjMEoFfzT+NPpNKDZDFql+GGnoNUBVAiD26is=;
 b=u7WsvtdWsmfFCVYOAoVrAPxFm1TvRW73QK4G3P4T1n+9Evaw0zb2YEcfx4CV/J6e2wuV/WtS/RPtVwNL2Ci/95Sxp9GsyupqzSrr5NxzVtPsrFvES3QpovYgcC65GPN/VmqDfaFGNeiXu37F1tfMXsXQePShLPcUAEGKpiFAVNq+otBZyz+qw/YotS3n8EIz816nIMCp29FJ2bh2LwNtB/kWSTclakwmjOdlbpA/U7wMcwXsuQvsIaBnhM+hGFjxN2j/Pc9l/vHPixWIVb5OivCY+61yUtUVJGyZ66TQb6mhX0+GsQNLCF8QGSu+6SYW41w+Gydfu6yuVfPHf7g0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2unm6xjMEoFfzT+NPpNKDZDFql+GGnoNUBVAiD26is=;
 b=eNeKhnfLqidnbB2jUDCiljG4TuRws38vppZm7Iz+mUeSK54ZiPGlUgizBVyZEfqZp+mdqgJXCVoRiBMsZjd71QeT3B0qwHjp38lhLXIh4TEPicAFl1M8M6NXGHob6a3zN6CSTnLP+LsquSinuL0e6tczkksZmatyHEIWZ3NiHLWB0IvwoW8pl1WOlV8g22Rcl6j16vD7TybXi0bxKZ/VJvp5KorwRuyEci7ixYhHvcAu982QRuC3oY2b9Ms6B/vrWS+Nzr4vuqN0mVhjYi1xiHhfQqRMikGMudWwaEeVGUjIlgWHT7A/Agu1WA1DMoNKFHvEj9FS1qPwn0IbkO683w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS1PR04MB9238.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 21:18:12 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 21:18:09 +0000
Date: Wed, 11 Mar 2026 23:18:11 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>, Wei Fang <wei.fang@nxp.com>,
	netdev@vger.kernel.org
Subject: Re: Disappearance of network PHYs
Message-ID: <20260311211811.5qsfxhj7wrpnusg7@skbuf>
References: <20260311153421.u454m3e4blkstymt@skbuf>
 <eb6edd0d-36b6-416a-bf74-676421f12f2d@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb6edd0d-36b6-416a-bf74-676421f12f2d@bootlin.com>
X-ClientProxiedBy: VE1PR08CA0027.eurprd08.prod.outlook.com
 (2603:10a6:803:104::40) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS1PR04MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f281459-6b17-4445-bc75-08de7fb3b216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|19092799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X8X0sR5SKyDxr36uw0d7ZkdhzIMhLEp/34e/bzQTfMQfVgmiikh+jGkk39RvPr0vaqmEKjEDZxKC58ThjZ5xJZ4LcHM0gec9xf5mZQ7LIAh/dlW4tnAYK7dLKTUqIgbyTdag9Fha8wuEFEwnF+bW9PpdW0ulE6lcylBc/U+7q8SSF1gvmpq60zKDIWW0l6UtEAU4j+JmS7cvPhamPkfeNzZNhd6uBQALm8uMA48ZRCuUwWKPQ6APekfsGeCEmVTWC8uDbYYF5XF2GN9EBexBODcM9PIrJ4CINOLv6KQSgMMqI3wPfxhtcelzxP1oKFdabNVc0u3i84w6Oec5k57EQo9W18+lIIGlJ2WHZ9NFwR72t2BEEziB3xH4IJRq4oNPQTPW1U8SJidguRCnPF8e0LwkCn/kfSw+yOW+kL9YVyRhiyjdLhthZLAr47IGC7lXUVEPnkFJBbMQ6j/xvieR6PVN7AstNniiKKChUXNnBS5O65BLYLx6yvS9APc8N0j78UpASd69FGcJZ4sqGRrg9RVfVoDijO7gqoH8Ay9konjpmCF20vLUJCnjrCNKW3ptzDK5fUrBC/1w/04gndgJH6484rGegUGac4IDSHURJiqYTtbFSmeBHtW/QFSNsKQ+WN110zKm3DZQjrSX5US2MxpuO7v0W07twSULuE+54dc/G0s+UJkFXRdXZ9AYp4fJGINRu8TkAGWHrzgjcVOOjMVWsKTcIQmdJtAJmHEc+bs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(19092799006)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5rPmhiv+HQrpRH4BAWkzkyZpRH+JklM/9BKRNvQrYgqdi8z4+5c6eqSgD74P?=
 =?us-ascii?Q?QC9HL8V4dYQEo+wT/34ItuPKGGJPonKYN6fRQiL81c8QOq3ygdv/NG7S9J8R?=
 =?us-ascii?Q?7qYhwe3lmvOxMFNVeXYLLIHYIt4lTKfnVJaYtq/n3aF3cQtx66vsZuh11+sN?=
 =?us-ascii?Q?s3kDkVfY6hT/eNbU1+gvghTZhiCSy5yxT6ai8d7bttC4adJ2ZeZXvbXMh8Jm?=
 =?us-ascii?Q?KMNxuUtfRUbelQKlveItlEPx0jqIUF7vT798d05WUflDBS+p6D4/SFzWckQK?=
 =?us-ascii?Q?ktATtcUn9vpQtF+Z13V02ByLimbeYUl492P2prIxhG6PUeig3b3djlOT9gfb?=
 =?us-ascii?Q?/ftW0jfWEe0ilV42CmXeQx7jyqWVmSvoyUegbROq7xCAUscYWw58ylcL3Phg?=
 =?us-ascii?Q?RnyT8HYXDXypqms6wCrayeYbt+SIAYfiEa1GjW1NFHOGilzOzo+2XJI6ob3B?=
 =?us-ascii?Q?Vs1ZGPnc5Ri3ULQglsU1VaLXM0lfSCQcQ4lQwPf0pkaYeOTxLZnbUoGkX+rz?=
 =?us-ascii?Q?arWzXkHyDgnLrV7CeYRHQxCVCQZkrBqU1dvttS/EPK/qfNvYtenj1l1HCx8O?=
 =?us-ascii?Q?qHBq6IsAIUbe9wNP1gu+DpwwsgWFEHI6Kqpc9Yb5o4Xrht70qsd738CPdJuW?=
 =?us-ascii?Q?kr0mDiu5yh3gy691LYP0Xqdd9x2h99qVytAyf02DkRWLdjYmY8JrdUMK5Nx3?=
 =?us-ascii?Q?yXQ+mxzrEv9Waa56HYfpM5F6Fee5kEZYD1MeoeZi5U4U++5eqGr3bUZrmyt1?=
 =?us-ascii?Q?FSPNZKPCgBjHLqh40pkAhtl96aDJaO5LpitzNPtAmEwoWekYCyav3uSl7pUG?=
 =?us-ascii?Q?ui5M0k4iQd4yztjlo49uyPtTQlAnqOkl11D3CCXDyvjUwjuHULlN+wBrVa9N?=
 =?us-ascii?Q?TlulnZyeyzby/043zqCfyczEFCEalcGr+IwmuXyf32sdEx/LVl/TxF76ybSJ?=
 =?us-ascii?Q?6YOT2ERKSw/nnZkYPyu9vm+07JuvoX/xk3FYHTQ37bhsfbaYjJ6KcXzhCTrS?=
 =?us-ascii?Q?x3ldNkCmz6MvcCkWli1F1ao+D2wN2NgsUv2tlspTE0A9ysbpu+4AhLv3K+nm?=
 =?us-ascii?Q?Mkwbxps4fZGOpLYlSDJLiKhYUhRHmrXIA3/MbdPbIChyPKauszNatRJ4b9S8?=
 =?us-ascii?Q?CK8jtVu6KPXR5ET/B0YjbEabhtemFpfv0XOdzj5HgZef7j61Y1iKQUbu7bB8?=
 =?us-ascii?Q?ztaoBP/AKdxSmUZbcLXiw8Qs/zjbziI27giLFod88pzttPd+pO40hdswuSOP?=
 =?us-ascii?Q?jIzrH8HgcMwKj8dOk65oyuipoI/VZUTnw7ihb8p3vUbzcW8nrWftBCEFqLBZ?=
 =?us-ascii?Q?Lr8DI3YUdHI8STDccz9cuBpqs7S8Lv0v/rlyRKEzuoxgGFFGlZC9/QcS6zyP?=
 =?us-ascii?Q?3dHOSH+Kaycu26yhhc+S656GYXUs6wPBUsYoMF02ERY8Zml8/VlW8vKvzkK6?=
 =?us-ascii?Q?XYoWkK//Cboz5NqI7bK4sVFd8Y7rkaTJ/oKZuwpgkdpSr9SMFCRsB+03eMTZ?=
 =?us-ascii?Q?XtXK4EZxU/Kox7Y8AwP3UqIHMG7RvIhXDHw1CDd89TaPOC20ATtaXwXcehPy?=
 =?us-ascii?Q?qYA7DHBKXtgpiE1Wi44MYlFki2E35TYWvlCXjLBy/H2vMQ7sibu3FV0OUACA?=
 =?us-ascii?Q?laX3w03w9i8yYWZO86wfVKpTTusmnHk15zEBDD+QEwtKvtekkWqsreLCpZDP?=
 =?us-ascii?Q?CttpldnHan5v9hEt7l+0xV1zFFpCruY5rywUx93nvYRcXzU/XAcyFY+jlKC7?=
 =?us-ascii?Q?sCV3+hYwJZUonxi46WD2ar3yYUNaqIp4rYw/yEpu91SCKFURJXi0WB1FvUsF?=
X-MS-Exchange-AntiSpam-MessageData-1: 05+KWwmAbQ1tnQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f281459-6b17-4445-bc75-08de7fb3b216
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 21:18:09.8527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4H5xVJHKNH9NlA4A9DeBqlbJg39/SYwTwI5+DkeGPBQp8yAk0bntV0I3RbsvF8YfR3yElzd3jjagwrl1w5D5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9238
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266778-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,armlinux.org.uk,nxp.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94D8026A59E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Maxime,

On Wed, Mar 11, 2026 at 04:55:48PM +0100, Maxime Chevallier wrote:
> One other thing could be to rely on phylink to handle that ? It's the
> one part of the net stack that already handles PHY devices suddenly
> disappearing, with the SFP case. It has all the logic in place to
> maintain the netdev's phydev pointer without the MAC driver having to
> deal with that.
> 
> And for MAC drivers that don't use phylink, we could consider falling
> back to the fw_devlink approach that was proposed, i.e. big hammer
> solution that has nasty side-effects but that doesn't crash the kernel
> ang gives user a chance to recover, provided the side-effects in
> question didn't kick them out of their HW ?

Phylink calls phylink_bringup_phy() from 3 places:
- phylink_connect_phy() or phylink_fwnode_phy_connect(), if the PHY is
  on board
- phylink_sfp_config_phy() if the PHY is on an SFP bus

When an SFP module is removed, the SFP state machine detects this and
calls sfp_remove_phy(), which triggers phylink_sfp_disconnect_phy() ->
phylink_disconnect_phy(). Then it calls phy_device_remove(sfp->mod_phy),
phy_device_free(sfp->mod_phy).

The on-board case is a bit different. The difference is that phylink has
no trigger to do phylink_bringup_phy() / phylink_disconnect_phy() as it
has for the SFP bus. The MAC driver is the trigger, as phylink is currently
written.

