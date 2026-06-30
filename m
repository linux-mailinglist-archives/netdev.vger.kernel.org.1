Return-Path: <netdev+bounces-303237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iR7jNwTUQ2rfjgoAu9opvQ
	(envelope-from <netdev+bounces-303237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:34:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7B36E57AE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:34:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b="bz0sm/DC";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303237-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303237-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AF98302E7B4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC0643C043;
	Tue, 30 Jun 2026 14:30:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFB42848AA;
	Tue, 30 Jun 2026 14:30:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829852; cv=fail; b=k05z5IvgpSZ9u12ek+rSKC34vVYaesqt6Q+sGlcOV+WB7VP9bfptufhS4d59d8SJh68zdivAaPLjY9kKdFjHodO1ldyI+3xQWTtb2k8k9r9GMrlmiuRHtUZLjNxLYGKq6xxcCPoMsEP+7W+qmhyLT/bNqv3ubtqmG6eF4+lkwIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829852; c=relaxed/simple;
	bh=dBMKscFx+Yi7LBeSuPRZtPfGBqtPN8uORiHq4WRogr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YKxQAc9HPcafXKJVyMGR54zZEU0xoiQuBJ1r8AduoDzridI04MtLV1VjG4rX6+k1cOkghNknYMc0YOmhYFVAswdEkjX4F5+sl63FohCM2fZlrIucF3Pl6nqUoUF/Jc3jgWc1+ijvJMFwA7oH8lFs2oWJqzwxCgd2sIva3F7mKF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bz0sm/DC; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeCNMf+8vpSzvrYYbe7fL+hPQII1y1F0MOn9XZ76w6/WXqx2UsQCHcyB7HaC+EhyYTBgcK61hUaAnLkUCQbZSkDM1x6+EsWPBfWlcBHTiJi/DWA9SGdaSWO0YU4z/FQDAbgGqdRZxiFuygyNzGP0IW3OwNeLxtwYMe1Kd+zxhNc5MQFI7VjNAP5Ai4LqDQUsDpbQ9+Cv8jZ85HLwyE0xpFZCUstRQYm7gywnPDDRa0RdsEVDDpsUUQxnA+h2/Yl0r2N51b/yzB0tqd3XdDmAT8RJRWBadKAWeUkgwFrzDSP/TBSX8fLwjYenBb60RngL+LPgdVPU6BuYSxD4ta+bFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTMXghSIfJ/SYWegnBUK1RbJuWOyv5WMi0LbU/D3dLA=;
 b=l131dYy7lrzCjtSzFQUTBLwrxuY/myP0+OdwUUyI2cMuay9aFyetLSkGS3wI/j1V6sthPqDtjWmWg4mLyXb4J2zfHTWPyuHviw/MXYOPkS/J0rGuIZc4YpSfAp0JipnTzeNtvKDrNtkuFjRG7CcWxqtV85I7zT9GKU1Kq3vKMsW8w73dKytjJ7tWFNK39K5HMiDsvCkHIdfOV/xgctHnFygpCK4ngvHxR96DxYHGCLc270Hi/SXhjfGxaNMgoZMebo20xkH1imlhkJX6MIc0jjflQEFYo5+L9i9S2MwQaXNT+XlUL60TNSVlLqbsl3CnDgEN9M1KM6aocC4PGgW+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTMXghSIfJ/SYWegnBUK1RbJuWOyv5WMi0LbU/D3dLA=;
 b=bz0sm/DCISOMhF/NpITFzxnleMa8vC7gBXt0HDsGII5nwTCKmF8U+ndmS54luXgkOvvlSUlX/awuj+oEubtnEGc2vsjAOfBDvATWScAxSnw9VFFdqr/ribB1Ao0KxDg2ZZqHzlip4pXflCwFqAtCkAplD+j8n/KKDK8dLsRGrFB42zSzablAxtsjeQ7ye67Eh8hjWwxnPgAW0ojMXtISf+pDI9AZoP/tnOJjhRQfeLBautuT07GBs1muD2AjQN/f/iBSw0+6NPaovMhBBigSt0xwhcyk1MS+8q0DYe0jesqowwGV0Pa8FgCYiz5xZ2mgOt++J2ylXLMpkmux3z08gw==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by PA1PR04MB10914.eurprd04.prod.outlook.com
 (2603:10a6:102:480::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 14:30:47 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 14:30:47 +0000
Date: Tue, 30 Jun 2026 17:30:43 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 10/13] dpaa2-switch: offload FDBs added on an
 upper bond device
Message-ID: <v4fdw3xflg4dwzp35v7r7fmp352gtdzef3ltci4seajlsbzki5@ushmdrfwreiu>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
 <20260629112309.154328-11-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629112309.154328-11-ioana.ciornei@nxp.com>
X-ClientProxiedBy: AM9P192CA0003.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::8) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|PA1PR04MB10914:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e74ce9-c0dd-4dd0-4861-08ded6b42d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003|27256017;
X-Microsoft-Antispam-Message-Info:
	IG5B2ItN2ntE89aq8/zGk/tBOKCq6Gu9hbfyByqHsIUNJ01gPmhNPvZNROb8FRyRsPyA2WFDXVDVrwP6teYqBL8+dA1/eDHIehnk2ZrKZQaToqcNc3ceU5CL9CmVJMkpO7PJzG0f0HxT9kykDv+5KJ1SnwXp0IsDyci9XIdnCzHMjc+XiAXdGmnG9EDrmxwNz5cdpe4JsyFK2b3ZPurMVkKuvHBgGT77Zb69kAn79Uix+jipibqbsM19LYFmaWryROsugRigiSa2EqviRadlawE/4ZomUY/zWyT3JXhkMpBRtTFeoSuI2bq4go0M1M1VIRNg2zDFpDJZ7Nst9D9ZVdyK5cOP3Dgu5PlBHOW0T+0/bb72nqmg29ntX/7Iv3eh/QLI2cxDm2B9sX8KsW9S6vTom+ofkPyShdd0lngBjIVMqnAvGr2zFbKq21+gNPk2/9KQV2wog/uRxzFftWHs7miaXDs0TTrV2xd1aGmH77VC5hElyYVzbOFslhh2y4Eo8WYB4wLXaL1RuJMUjlApEIXpvXb8qyXHbtAJ0PGYgV5Lq2q/++TqmTVmjCrp8gDzQx2LmG3DRjmqEoqZhsq2h97UldWlQnBTVUOmBQAuKclwwxZicEFCJriDZWgL7o/Q4u4RKpo5bM8ecx48T9nm20hbYOfnMtUeAIE81GQI+Zq17aYXKVA1s4sNUokcpiOcv8Rm05NkIDMHlEv4cgvv3A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EHQkpxshwN008Rcii8XG9wzEGsAb57OWy86iPqUlqLV70S5gijRrRYm2/KmV?=
 =?us-ascii?Q?pRofiQr4RInZb2iqiflwFTQ9RXhmOCD1RxH3yRSSQSYC4kI3pcB+7ofi5ixM?=
 =?us-ascii?Q?OxMtvHuNK0Oo3tAuMJBuXnXuXwoGfT+k5JlDwvhXvu/989Jg71g6Ji7+SIW9?=
 =?us-ascii?Q?16KWmNJRFXupZPMojguOr86ZDwI5RvlaOXA2qteeKcsRcbemw9ZnYQzR6RFj?=
 =?us-ascii?Q?0tsZp3x0W1mCNanZ9UEaN01p5HzMccUybfDXdTN1mFud/Tw9qOU3cXqvffiN?=
 =?us-ascii?Q?g9HSTNH8NgyxfJQ91sXcqSvdbH/Q/OOn/s+KGx8v5YpqmpGH3aiVngMxz2hu?=
 =?us-ascii?Q?Oi4bb82egA9I/mX19z61Se1ok+vPmKcZuacdo6cT4P0JEpS8GiHN0zhcUHjq?=
 =?us-ascii?Q?NZO/oWhmTzo/U/JmZnmu0AkVepQgTh6tOvYxRNGetzTrLc4oCwWePh0XzU3S?=
 =?us-ascii?Q?936IWBCN/Zz/r/2WKHvunucDQiMEmXW6A0bC2ku4KD5c7TEC5fdAxVKDM+O/?=
 =?us-ascii?Q?fEG4MwNH1hfecTD/KNMw68Uz+8ELz+PddsLtwCoE2suzy9Kk+oHT+IvzmZyn?=
 =?us-ascii?Q?z7n2bZfr9SppQObM9Ra2SxgpqD+oIgEE5mdH9SijgKT/xdrR9w+vYSzhwvCM?=
 =?us-ascii?Q?6q5ySdDbxgJAMkJafPdWS+NryXJuvmY2zENVBNHDDiIn34Zf23G20MpdAUwU?=
 =?us-ascii?Q?uEW0ENif8B40l7CbnFoLGEdi/7ybGZcQkr+JVYGBuEsSqj+GaxjFZFI2fNT7?=
 =?us-ascii?Q?taqlFivpLk+wUaYkVn1fRo+mHCPVVlvM5AEcWPTNrqTeOtI8T8IGeLXZAhm1?=
 =?us-ascii?Q?Ht32jOob9HuoskUXZG2lC71Gj3Gr7Pt4Wa+0qpq1YwQh/882Xx3+7KedX3Iz?=
 =?us-ascii?Q?O88OoyRuM4sw4g035QDZ44cmwDrGHefysSiAzX+3trGcczQm4FR0rXIiypcA?=
 =?us-ascii?Q?9H23ZZqxyw6hBNMdIk+zKj5pMUYbEX8p9T0ws5St7X4/0sIR/hu9wiVrJO+g?=
 =?us-ascii?Q?7wy0AfylfQ1qUn0JIPm4EfwhO2bphBHrSTh90ouvwkLyv4Vx3yPS8Swpy1TN?=
 =?us-ascii?Q?BlthwmNwfTCV8HGKTvBrvLlFlL4f92rRg2HE+esNQj13gdfJFcusC2qRGUBh?=
 =?us-ascii?Q?i066AkqDLbDFmGmW27PT8+gmbdJwKM123u6p/WbRlclznLc6nL3W8DTpxVhP?=
 =?us-ascii?Q?cKLNsYdjr1VYsQpuMVTTdGiPenvAwpaQqpez6xfOJVXwsvE+T710nAG3wxRK?=
 =?us-ascii?Q?2G+mequco7gmapGR8EhX9xu2LO0rFCzVt9/G/IiR/ig+amyzqIe4yo5BDcvZ?=
 =?us-ascii?Q?4rl4G4dteH4G5b/iLoo5X/nYh7MLIkvRqFm17d0A+oxCEnbfWG6Fgtm+Am6d?=
 =?us-ascii?Q?udiX0hA6wtP1PtToOJuMITVotk7BM/A6Lx34Huqdl9SuMfqteW0SjmbNjXE9?=
 =?us-ascii?Q?p+oLHjwg9FX0Q8Y+6FQMYqnkxfZ+deCTPDpwETRT4CIdt8ymnPDR0zjqihu2?=
 =?us-ascii?Q?I1C6SbgxiBlo9twb/GN726QTBZZydrtnwPbl5ypVReMQ+HUvnUz1gaFPzWCe?=
 =?us-ascii?Q?M7Y88dyjVuO2QG3WxeIb2cApgkq8sU3OHsi10Dsf1cZS+P0vCtP+WCpHVLpV?=
 =?us-ascii?Q?3zAKlNXw8BGe/lcYXs4Nm4IpmXce+/zJjQ4ap+fos/ATYxxNa9SYQeoZ/jUf?=
 =?us-ascii?Q?YtJiy2Yg7XJckzy6xuL43Z2DbNeJubGLZJRRnJuKiz+AT+FDwVMuGLXD6cA9?=
 =?us-ascii?Q?71TaiKH4iA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e74ce9-c0dd-4dd0-4861-08ded6b42d3b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:30:47.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /moKoV2FuQdh8LRgCwq3mvytOX1jAeFNbn33cwLQgPr8hrCgbRQr6psxF1a5x3iwT2FYnoQTho9uBAYWJVddQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10914
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303237-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D7B36E57AE

On Mon, Jun 29, 2026 at 02:23:06PM +0300, Ioana Ciornei wrote:
> This patch adds support for offloading FDB entries added on upper bond
> devices.
> 
> First of all, the call to switchdev_bridge_port_offload() is updated so
> that the notifier blocks needed for FDB events replay are available to
> the bridge core.
> 
> Using switchdev_handle_*() helpers is also necessary because each FDB
> event needs to be fanned out to any DPAA2 switch lower device. This
> triggers another change in the return type used by the
> dpaa2_switch_port_fdb_event() - from notifier types to regular errno
> types.
> 
> Handling of the SWITCHDEV_FDB_ADD_TO_DEVICE/SWITCHDEV_FDB_DEL_TO_DEVICE
> events is updated so that the newly dpaa2_switch_lag_fdb_add() /
> dpaa2_switch_lag_fdb_del() functions are called anytime a port is under
> a bond device. This will allow us to manage refcounting on FDB entries
> which are added on the upper bond devices.
> 
> The DPAA2 switch uses shared-VLAN learning which means that the vid
> parameter is not used when adding an FDB entry to HW. The current
> behavior when dealing with FDB entries with the same MAC address but
> different VLANs is to add the entry to HW every time while removal will
> get done on the first 'bridge fdb del' command issued by the user.
> 
> The same behavior is kept also for FDBs added on bond devices by keeping
> the refcount on the {vid, addr} pair while the HW operation disregards
> entirely the vid parameter.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v4:
> - Migrate FDBs in case the primary interface of a LAG changes.
> - Use lag->primary instead of determining each time the primary
> interface of a LAG device
> 
> Changes in v3:
> - Update dpaa2_switch_foreign_dev_check() so that we check if there is
> any port in the same switch as dev which offloads foreign_dev in case
> this is a bridge port.
> - Add mutex_destroy on the per LAG fdb_lock
> - Make sure that all FDB events were processed on the workqueue on the
> .remove() path.
> - Delete the refcounted entry in dpaa2_switch_lag_fdb_del() as soon as
> possible, even if the HW deletion would fail
> - Access the port_priv->lag field only through the proper rcu accessors.
> 
> Changes in v2:
> - Update dpaa2_switch_foreign_dev_check() so that we check if between
> the switch port and the foreign net_device is an offloaded path. Before
> this change we also checked if the foreign_dev was offloaded or not by
> the switch port.
> - Update the switchdev_bridge_port_unoffload() by passing it the proper
> context and the notifier blocks.
> - Add dev_hold() and dev_put() calls for orig_dev
> ---
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 227 ++++++++++++++++--
>  .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  24 ++
>  2 files changed, 225 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 949a7241a00f..307b3b7a1bfb 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -25,6 +25,9 @@
>  
>  #define DEFAULT_VLAN_ID			1
>  
> +static struct notifier_block dpaa2_switch_port_switchdev_nb;
> +static struct notifier_block dpaa2_switch_port_switchdev_blocking_nb;
> +
>  static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv)
>  {
>  	return port_priv->fdb->fdb_id;
> @@ -585,6 +588,81 @@ static int dpaa2_switch_port_fdb_del(struct ethsw_port_priv *port_priv,
>  		return dpaa2_switch_port_fdb_del_mc(port_priv, addr);
>  }
>  
> +static struct dpaa2_mac_addr *
> +dpaa2_switch_mac_addr_find(struct list_head *addr_list,
> +			   const unsigned char *addr, u16 vid)
> +{
> +	struct dpaa2_mac_addr *a;
> +
> +	list_for_each_entry(a, addr_list, list)
> +		if (ether_addr_equal(a->addr, addr) && a->vid == vid)
> +			return a;
> +
> +	return NULL;
> +}
> +
> +static int dpaa2_switch_lag_fdb_add(struct dpaa2_switch_lag *lag,
> +				    const unsigned char *addr, u16 vid)
> +{
> +	struct ethsw_port_priv *port_priv = lag->primary;
> +	struct dpaa2_mac_addr *a;
> +	int err = 0;
> +
> +	mutex_lock(&lag->fdb_lock);
> +
> +	a = dpaa2_switch_mac_addr_find(&lag->fdbs, addr, vid);
> +	if (a) {
> +		refcount_inc(&a->refcount);
> +		goto out;
> +	}
> +
> +	a = kzalloc(sizeof(*a), GFP_KERNEL);
> +	if (!a) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	err = dpaa2_switch_port_fdb_add(port_priv, addr);
> +	if (err) {
> +		kfree(a);
> +		goto out;
> +	}
> +
> +	ether_addr_copy(a->addr, addr);
> +	a->vid = vid;
> +	refcount_set(&a->refcount, 1);
> +	list_add_tail(&a->list, &lag->fdbs);
> +
> +out:
> +	mutex_unlock(&lag->fdb_lock);
> +
> +	return err;
> +}
> +
> +static void dpaa2_switch_lag_fdb_del(struct dpaa2_switch_lag *lag,
> +				     const unsigned char *addr, u16 vid)
> +{
> +	struct ethsw_port_priv *port_priv = lag->primary;
> +	struct dpaa2_mac_addr *a;
> +
> +	mutex_lock(&lag->fdb_lock);
> +
> +	a = dpaa2_switch_mac_addr_find(&lag->fdbs, addr, vid);
> +	if (!a)
> +		goto out;
> +
> +	if (!refcount_dec_and_test(&a->refcount))
> +		goto out;
> +
> +	list_del(&a->list);
> +	kfree(a);
> +
> +	dpaa2_switch_port_fdb_del(port_priv, addr);
> +
> +out:
> +	mutex_unlock(&lag->fdb_lock);
> +}
> +
>  static void dpaa2_switch_port_get_stats(struct net_device *netdev,
>  					struct rtnl_link_stats64 *stats)
>  {
> @@ -1533,6 +1611,33 @@ bool dpaa2_switch_port_dev_check(const struct net_device *netdev)
>  	return netdev->netdev_ops == &dpaa2_switch_port_ops;
>  }
>  
> +static bool dpaa2_switch_foreign_dev_check(const struct net_device *dev,
> +					   const struct net_device *foreign_dev)
> +{
> +	struct ethsw_port_priv *port_priv = netdev_priv(dev);
> +	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +	struct ethsw_port_priv *other_port;
> +	int i;
> +
> +	if (netif_is_bridge_master(foreign_dev))
> +		if (port_priv->fdb->bridge_dev == foreign_dev)
> +			return false;
> +
> +	if (netif_is_bridge_port(foreign_dev)) {
> +		for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
> +			other_port = ethsw->ports[i];
> +
> +			if (!other_port)
> +				continue;
> +			if (dpaa2_switch_port_offloads_bridge_port(other_port,
> +								   foreign_dev))
> +				return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
>  static int dpaa2_switch_port_connect_mac(struct ethsw_port_priv *port_priv)
>  {
>  	struct fsl_mc_device *dpsw_port_dev, *dpmac_dev;
> @@ -2100,8 +2205,10 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
>  		goto err_egress_flood;
>  
>  	brport_dev = dpaa2_switch_port_to_bridge_port(port_priv);
> -	err = switchdev_bridge_port_offload(brport_dev, netdev, NULL,
> -					    NULL, NULL, false, extack);
> +	err = switchdev_bridge_port_offload(brport_dev, netdev, port_priv,
> +					    &dpaa2_switch_port_switchdev_nb,
> +					    &dpaa2_switch_port_switchdev_blocking_nb,
> +					    false, extack);
>  	if (err)
>  		goto err_switchdev_offload;
>  
> @@ -2143,7 +2250,9 @@ static void dpaa2_switch_port_pre_bridge_leave(struct net_device *netdev)
>  	if (!brport_dev)
>  		return;
>  
> -	switchdev_bridge_port_unoffload(brport_dev, NULL, NULL, NULL);
> +	switchdev_bridge_port_unoffload(brport_dev, port_priv,
> +					&dpaa2_switch_port_switchdev_nb,
> +					&dpaa2_switch_port_switchdev_blocking_nb);
>  
>  	/* Make sure that any FDB add/del operations are completed before the
>  	 * bridge layout changes
> @@ -2425,9 +2534,10 @@ static int dpaa2_switch_set_lag_cfg(struct net_device *bond_dev, u8 lag_id,
>  				    struct ethsw_core *ethsw)
>  {
>  	struct dpaa2_switch_lag *lag = &ethsw->lags[lag_id - 1];
> -	struct ethsw_port_priv *primary, *new_primary = NULL;
> -	struct ethsw_port_priv *port_priv = NULL;
> +	struct ethsw_port_priv *primary, *port_priv;
> +	struct ethsw_port_priv *new_primary = NULL;
>  	struct dpsw_lag_cfg cfg = {0};
> +	struct dpaa2_mac_addr *a;
>  	u8 num_ifs = 0;
>  	int err, i;
>  
> @@ -2454,7 +2564,6 @@ static int dpaa2_switch_set_lag_cfg(struct net_device *bond_dev, u8 lag_id,
>  	/* Build the interface list, always placing the primary first */
>  	if (primary)
>  		cfg.if_id[num_ifs++] = primary->idx;
> -
>  	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
>  		port_priv = ethsw->ports[i];
>  		if (port_priv == primary)
> @@ -2477,11 +2586,32 @@ static int dpaa2_switch_set_lag_cfg(struct net_device *bond_dev, u8 lag_id,
>  		lag->in_use = false;
>  	}
>  
> +	/* When the primary changes, migrate the FDB entries from the old
> +	 * primary to the new one: remove them before reconfiguring the LAG in
> +	 * hardware and re-add them on the new primary afterwards. We do not
> +	 * touch any refcounting since the intention is to change the HW entry,
> +	 * not the parallel software tracking.
> +	 */
> +	if (new_primary) {
> +		mutex_lock(&lag->fdb_lock);
> +		list_for_each_entry(a, &lag->fdbs, list)
> +			dpaa2_switch_port_fdb_del(lag->primary, a->addr);
> +		mutex_unlock(&lag->fdb_lock);
> +	}
> +
>  	err = dpsw_lag_set(ethsw->mc_io, 0, ethsw->dpsw_handle, &cfg);
>  	if (err)
>  		return err;
>  

sashiko-nipa notes:

	[High, Medium] When the last port leaves the bond, the block
	above sets

	  if (!num_ifs) {
	  	synchronize_net();

	  	lag->bond_dev = NULL;
	  	lag->primary = NULL;
	  	lag->in_use = false;
	  }

	Can a queued workqueue item still race with this teardown?
	Looking at dpaa2_switch_event_work():

	  rcu_read_lock();
	  lag = rcu_dereference(port_priv->lag);
	  rcu_read_unlock();

	  switch (switchdev_work->event) {
	  case SWITCHDEV_FDB_ADD_TO_DEVICE:
	  	if (lag)
	  		err = dpaa2_switch_lag_fdb_add(lag, fdb_info->addr, ...);

	The RCU read section ends before the lag is used, so the
	synchronize_net() in set_lag_cfg returns immediately without waiting
	for the work. dpaa2_switch_lag_fdb_add() then reads lag->primary while
	holding only fdb_lock, which the writer does not take. If lag->primary
	has been set to NULL by the writer, port_priv = lag->primary; ... in
	dpaa2_switch_lag_fdb_add() will dereference NULL through
	dpaa2_switch_port_fdb_add() -> dpaa2_switch_port_fdb_add_uc() reading
	port_priv->idx and port_priv->ethsw_data.

	The in-file comment claims the lag pointer staying alive is enough, but
	lag->primary is a separately mutable field with no shared lock between
	this reader and the writer. Should lag->primary itself be protected by
	fdb_lock (or by the rtnl/RCU pattern actually waited on), or should
	the bond-leave path flush_workqueue() before clearing primary?

	A related window exists during the primary migration below: between
	unlock of fdb_lock after the add-loop and the lag->primary = new_primary
	store, a concurrent work item can still observe the OLD primary value
	and install entries on it while the HW LAG is being reconfigured. Is
	that intentional?

Not correct. As stated in the commit message for 2/13, any concurrency
between on-going work items and changeupper events is resolved by
flushing the workqueue from the prechangeupper event.

Ioana

