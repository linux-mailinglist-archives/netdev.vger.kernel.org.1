Return-Path: <netdev+bounces-266682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AU3AB2MsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:37:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68707266A9D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3631E30062D3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2536C9D8;
	Wed, 11 Mar 2026 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YP+AbHKx"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE15534752D
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243268; cv=fail; b=t0h3f55HcqjiVdy8DoPQEk/sVWRLdpdaXOvx1YRaAt0dBkAJiace3O3jEXpLRvXf5oVihY5S6hnQGRTtSVac7JO1sAiUblyd3qE74oc/rY/Ox3uy/AaeMjvAOB9jSpn8vNjLAVorop9Oue0HcfsyV8jTtf3Iv9j1qQuvWophYpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243268; c=relaxed/simple;
	bh=pPa7NeGFkU+Zr79lJ4lXrXbBhBzeAxkxMERbFlZWadU=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=izY5+ZtjRqmYJVEDXPX6op9/BVlPgQrHrZiKXTeXU2lkaTxzWQ/cgr5f/JR9wjw++DuQ3wsO7DLEFeQiNKh+TYJvIGxcYiQ4xuMcuTawFQzKZoWmM4vAWaqnackZjwoINrB1wUhXRFgBob/cQCDHX85YuWdp4/Vj3o8bHzLZxRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YP+AbHKx; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2AQLNGKQ2yJwGtkObw7/k0cDO0rwkifjtW6FCMgOiPe0OZEKYcBV+KB+EHrZCSbAuh15Pw/NU6oCwoigWB8xw0HeBbpr7H+OrmKWE6JUpEyYMkScS3eLIc09PiK0tjKZ/VYX6Nxs3/6a0zwPD/E3paBJf+LEQ753t8kkCy/DeM8pr0bsJRfsX89FqENhcbi9p3A0o076XQC3Fqw6kSHjc7TPOwNdkd9cSadOjONHwuVaqviFCGvyv1dwai6KRD0ssQCKRPyL7K6ZSnvSz8uB2Bdn0K7vtUmvLornXVRUmzNBKewuCuYCFTqqRg/GfCvyXMo2Y7VhakxYqCDxmX9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkrFyqOQEvt0vx0lLNwSlVxPmH9EDFlvkXqpgp7amD4=;
 b=mZQRU0lPts3ypMJwzPLqLaHVB/qj2MXCDpPDvkjqPnXQ0LvXeyM7jRk/cMyxU4lAjQkNOs4giOrnN+QYK9i3EZxOoaB6/Ev4ulf4McD6he6XfRJbZPmnLFGqL34d1bnGOFo9dJIr6K7uMPPiNjy5MLdZ1fFGQjiOJnPaL7rnwascrPXYkF044pQFWmvw0VEZcuBkJRwC42L8lULiSMZNbRisYvtQ0uiegEg6x6yzXA2E+5bd3ngj5RZk1zKoBP2uzuu0Gfv7Jfw9lsAHvy04Aop3eokPXbeWONpx5zyUxWGmNneA/3rs3561uixAgsarHg0tR15ut+6BiE3gXL0Qgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkrFyqOQEvt0vx0lLNwSlVxPmH9EDFlvkXqpgp7amD4=;
 b=YP+AbHKxZt3V1eIaSA6mfTA7fivr9Ay6nWCKaGlBEMKbyO610DoWS05hUYFyTnZscyW3/fYSAOIugjV50osgTZJdrJdH2szUwiaV16TYIJt0SohpELzYs9TwoRiV10V1Q8pWx2nUEN3++EiWWMGUlOyV0jOEma0PQ6AtDvpWlvEnP1PWO+FS1JXgbZcEOEC7PJUUOhOMrDF9ztQZWupSR6Q0CG1xecuzH9Vl9ow0AcE/+9xU8as/l847ZfXUVsgW/iDR3jxceANuXg2EXtMF9uzetN5jLHUHd4roEgaD7X6UhWvd+jzVaP17RLYXK+KLpQyZ9CF5XomTzvx7UNaIpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7507.eurprd04.prod.outlook.com (2603:10a6:20b:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 15:34:23 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 15:34:21 +0000
Date: Wed, 11 Mar 2026 17:34:21 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>
Cc: Wei Fang <wei.fang@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org
Subject: Disappearance of network PHYs
Message-ID: <20260311153421.u454m3e4blkstymt@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BE1P281CA0274.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::19) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 779d7965-d882-4acd-fffd-08de7f83aa96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|19092799006|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YrbPVlvb2zVfodAHlZGAkIaC8LXUy710RCvQoPKAKJLgPmQIj3dsqdgNYI6/+urhBMNRMjPneb46fsdoezTqUrmQpZ5hNAdfX2QnsffmZEwszWsHXb6WQ/nBfQKiCFjEtWlXK1TpTzKc5x3/BA1ID/yDVAYTSlIbxFT9uoCp9LDoBdNgrVgmiB1JWuKqK8ug2MFmzreF+S2aslYGlH+fs4oM5/dKztVzllNN8BCmYBrih+duWFd06iNUJcOzJ1BnYygTrfOV3J/zuxqyWSEylqQK4VD4zQIrbS0WNt7GEEyJ8igwG3ivuG9c6/A4ZAsLMaTXX08dN2INEakwzbD1MkCKThcpIK8qCzlHEWC5nEZu47GilZeVhf1CWMimYBrt6BObWfTwNFu8+RZY6c05osLan+TRvYVTGWkaBN1/NL4LZRSd35k9jyo1A/ZMq/uyaqiEclc44EyZtjNPoX9/i54dRgmU3vzNvz0pKFJB8mmfrV080l1vjaXejESI5tbm9DWXFAjeeiemDZkXZyFqNZCApmi76wwot4xRncT84ULSFE9bLPhzaut7UoI0UbnrIatj9NZkSChaueFYvmmdOg6tW/Eyd1ICn/fkakKy0goo40j3dLpyYO5lRPQkKuqJzKz8hu7rDXwNOV7xhPviUnh0PeBBSpgWMNk2FPtXSHhbN4XaUkt1qbZI2bnKbgaR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(19092799006)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O6cRIgx6a+4C0DBAr6TN/VHBSJOUNgs2T4db7wsfraNjeY+ZqT1zRt5lZczZ?=
 =?us-ascii?Q?5pSk5geakVcKUd1Cl4hk9HvmjsXv9QL5L6eLkbIvN4fq/BZfY/GVGbBty1ZI?=
 =?us-ascii?Q?JKRoy5vGSy0vYR9s0uduZIYlug1ft/Eit4qZR5RrMkjddh/WyTFTQA+YIDpK?=
 =?us-ascii?Q?+UpfHV/xGmnhxreOhYALl3nxadHYigoYUQ1kW0InnLA4BXCUxNnydpQaEyy2?=
 =?us-ascii?Q?MaJ8c3Iw/1QQx3Ot8sACdOXv2ej2t60m/fQJi7ROOO7e1qcQ2MPSlrW8JaeH?=
 =?us-ascii?Q?HCo0zgfOSxZ8Ik7USTTT1ZMeKsJtCww8TAOcNqwSIgBSvh07o6MUK2l6DJ7g?=
 =?us-ascii?Q?jMCBH1UctBKgkxqTs8MPLC08RVaDh5b5PoWci40luLtpuX7dxAsHAVeROBkQ?=
 =?us-ascii?Q?qoNBKxFmy6w8auSCZ8552k7SU+7jkmTEDMALiu2KkMsXcPuJwA5A/ImeCahq?=
 =?us-ascii?Q?ogXzWoH9cF4ZnqB51nCZoIioatScbPQb+MCgUX1mmR8HGoXcZSQptSbCDH9r?=
 =?us-ascii?Q?mQmVuWPwTezMiHZZJcZtcTBgJNNxCttNnfcWlyIowtQa4bhahUYDq7q2SBRp?=
 =?us-ascii?Q?byUHTQ8IjXlS5tA9J8PfzQWrYUaO1DOeE68yWKAToXNWovZfddFSTQci8UPI?=
 =?us-ascii?Q?O0qmpeFcgDHo9BrP11WX4cIjkpU+NizLiV//r7sFbUIMIkvhcZ/M9+QBvYv9?=
 =?us-ascii?Q?iTX0o5CvEn7jq0+rZkdhcUYEsOoSQij44Xou0M/p29ZpXl6Codkh+3Ln37ml?=
 =?us-ascii?Q?VLkpVkexYrc3jJrAMPm7YYEo4lF6IT5JvvTAVJFMB7THHdPWYfx4O7aknBK+?=
 =?us-ascii?Q?LbmbWiD9g15DZjgiRTwePWoZH2dhq3xyyqr8Pe5QzokpxIayJiKkkibN7fi2?=
 =?us-ascii?Q?GjStM7WOiVZl7rSIwGvP1vW3C5sJ5InmzVHW7Scv8mIvvRuWMo0ncyexZHI9?=
 =?us-ascii?Q?iFYUzKLN3kWos5x1Vp+A9ivSkD3WB23AnLwfrLeMQQinJbvEdrMSlpYhq8Ok?=
 =?us-ascii?Q?jCV4ds/HgnuMniow7tmzC5SRNdueIDbjy6TBT4/FiCd/8wzgkvMF8KLC0J8n?=
 =?us-ascii?Q?h7ua28CNMuSe2iuDf0KSxcwAnW5tnVSGIn8+kkAOGfsFNWs6GiHMcDf5XelU?=
 =?us-ascii?Q?qrtLqLJrs9vO4RwIdGhWp9h9ptFz4MnZhydc7y1FB/ry9+Bt9tH0DWJ6m8E5?=
 =?us-ascii?Q?QKfopJ+Dzsur/nxqdwQdbRbL0oQEppbuqRX/RLg8m2ifkAHBg9mQJvgfDWIa?=
 =?us-ascii?Q?rCJZ8Di5SP/FIapbhyMDI8u1M3hwNMdAaTjb5hSzGx9LPBLYslmrsoVsepyt?=
 =?us-ascii?Q?zohYS/6L+WfUzDmzTbIHyYJ3poB10Yhiz0j4OcFYeLqsBo49tLzsyZPZnce7?=
 =?us-ascii?Q?WZWTk9JsZ/R49J5BwX6wuC+GcjHIJxJV5w52KkP/ofM50CPuwkfL/BigEXgr?=
 =?us-ascii?Q?LPhRrrszeDptQH0e9YmGg8y2VPnH9m/xbA/iRuR3e9dxCEXkjH5aiI1zRqNQ?=
 =?us-ascii?Q?VZkgD4SjPIPQRjeIsLB7OHBmVd3kF3/CKM1UjsrMD7TDVCtEvlgRLxhmoKaL?=
 =?us-ascii?Q?Ec0ajDempskFAjxesHoNO4LKDDYnbRTd3ivZ/mjduIosnLp9WyqD5LPhpegB?=
 =?us-ascii?Q?Fmr9RKZ9rxPXqLH6RbAjUzj8Z1rYkoj5BhtSL8wIkZe4ycTsN34RXKGRDi39?=
 =?us-ascii?Q?nV4SRhFnY4mHB9zsGYVRGGwkj6bUyMUvIIlqRiE21tOebfZ8IMcFShMtfomf?=
 =?us-ascii?Q?0VNg+hyXJcGHEnU7//5D54acxUAJTPEptU+Iv6JJDaG9gAXUedlpxNnfEqOX?=
X-MS-Exchange-AntiSpam-MessageData-1: zoEC5m4Wy8XajQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779d7965-d882-4acd-fffd-08de7f83aa96
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:34:21.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noAJ4Ssj/AiNGzPT8+BE/Zy4KBk2sWxdO7AfUruw6SaPw2IIsr4xnvJD4VQ04QWAeWjIq6hoRNAUZavzxvPv/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7507
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266682-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 68707266A9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This is a follow-up from this thread:
https://lore.kernel.org/netdev/PAXPR04MB8510CB77C95D4D044FE62C64889BA@PAXPR04MB8510.eurprd04.prod.outlook.com/

I picked up from where Russell, Maxime and Wei left the discussion more
than 1 month ago, and quickly prototyped patches that would mechanically
remove the kernel crashes caused by invalid phydev dereferences from the
MAC driver of phylib/phylink, when the phydev goes away.

(far from perfect, may still have deadlocks or lockdep splats) PoC patches at:
https://github.com/vladimiroltean/linux/tree/phy-remove

I ran out of steam because I'm not really sure what we want given what's
possible, and I don't want the effort/discussion to completely die away,
so I'm asking the PHY maintainers and other interested people for advice,
while explaining what I found to be (not) possible.

Mechanically, what happens now in my branch, with a disappeared phydev but
there's nothing that can crash the kernel, is that the netdev carrier state is
in holdover mode. Meaning: if the link was up before, it still is up; if it was
down, it still is down. Furthermore, traffic still works if it worked
before. This is because the PHY is not an active component to the data
path (I am excluding things such as PHY timestamping), and I've patched the
state machine to preserve the last state and do no further work.

However, if I stop and start again a disappeared phydev, phy_start()
leaves it in the PHY_DOWN state, to avoid some WARN_ON()s. This is
admittedly inconsistent.

This serves as an illustration of the most complicated part of surviving
the loss of one of your providers - what to do afterwards? The MAC driver
may have done stateful stuff with the PHY prior to it going away.
The netdev->phydev pointer persists, but even if the phydev later comes
back - it's no longer the same phydev and those operations need to be
repeated. But how to repeat those operations, when
(1) no one kept track of them
(2) the netdev->phydev that the MAC is holding on to is not the same as
    the new phydev that gets created on rebind

So even if the netdev->phydev pointer lingers on, it is effectively junk and in
everyone's best interest that the MAC driver gets rid of it ASAP. And then do
what?

There are 2 distinct cases to think about:
1. MAC driver connects to the PHY at ndo_open() and disconnects at ndo_stop().
   I can see something like a forced admin down from the kernel (somehow).
2. MAC driver connects to the PHY at probe() and disconnects at remove().
   I don't see how these can survive the loss of netdev->phydev in a meaningful
   way (meaning: have a way to recover when it comes back).

Actually DSA belongs to case 2, which complicates the discussion, since it is
one of the reasons we don't consider device links as good.

However, I must point this out. Device links provide a very reasonable and clean
answer to what should the MAC driver do when its PHY goes away. Unbinding the
MAC makes sure that none of its internal assumptions about PHY state will be
violated when the PHY later binds back, and it doesn't require complex tracking
either. It also scales to multiple (and different kinds of) providers, which
can also go away, in much the same way.

Sure, I don't like the side effects of that answer when applied to DSA either,
but maybe that's something we can work on, while not fully rejecting it.

Some ideas, mostly listed as conversation starters:
- Modify DSA to connect to the PHY at ndo_open() time.
- Modify DSA to register a separate struct device (with generic DSA port driver)
  for each port. Link the net_device parent device with this port device.
  The PHY device link unbinds only the port device, which can be later rebound
  via sysfs. Solution gets repeated for whatever other switchdev/multi-port
  NIC driver is written that uses external providers. We modify
  Documentation/networking/switchdev.rst to make driver authors aware of
  the problem.
- Create an optional notifier chain that the PHY is going away, which the MAC
  monitors and informs phylib that it does. Drivers that don't inform phylib
  get unbound via the device link mechanism. Those who monitor the notifier
  don't get unbound.
- A combination of the above

Any other thoughts welcome.

