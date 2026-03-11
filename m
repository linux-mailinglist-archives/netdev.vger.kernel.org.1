Return-Path: <netdev+bounces-266772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMdBE83RsWnQFQAAu9opvQ
	(envelope-from <netdev+bounces-266772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 21:34:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9919269FC5
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 21:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 659BF30420B6
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18A5324716;
	Wed, 11 Mar 2026 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="desBFOHH"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013014.outbound.protection.outlook.com [52.101.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4C347FD3
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261258; cv=fail; b=hFqOFh4T6wBpCSMa5t1NS2THYwdpDgOncOI314TI180Lgju//GximZ9EKxhj/MD80fGo2++VbOSRarYxcXrEQcs73cmc6dXBlpC6sQ+oiiN85k9kUghzvAo2u14piRUm0JyTzXPqT9L9SkvR++tTxgx/G7ll4jnyriKtdMieTNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261258; c=relaxed/simple;
	bh=9YfmH9VPNjzlQOrQShUhCitNONAUD2UfBwR/IR53xB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SUksRw5xobbVmJbBrKKd+/M0dnu77IXIUE3d54TtS949qCghYfwEApptEf48NzxZmedRLpmXmE5ZJ7r+I/C6OYhUQGaBdpMEs7zXaZ3SmETUvwqQHkfGC/FgFrTjLFhkjNRhT3H42Skj9twWzsKhr5EL16hpS4TCozbZGSK3Rng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=desBFOHH; arc=fail smtp.client-ip=52.101.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lF3qEuFsX36DtzuUZNhHIvxPKe8roFoIYGZVlknO8o1yUgRTZ/fRPXN0opeSEpQv+5mRsxLVRJRaLEJiTCg0TdBnHnEatcBIhs+2B9ewy6MKSdGNt+LltTXs65aKCsftMpdhWaAyYEV4+vSfddoohhT9tRaexOTdF6T1pSofspuP1UI8V7rb1Pf4nixX1Hl/xs1MSkOjM/9c4EeZX5kMElHP8O7eGkISWEX6w8qfrhcGrktZFLFXHqVvbdcq7WXSMM8ZBxIhyP92RiH8rINie76X+5Cm7U5i74H1vFpDfBUJjwf0ULZRliVdG7R35iy50PQ9zTFa0XhM0etCqEU6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwqpmSMGh9l+PfzIvYwQYyBpCivENE17EiTSj+kPtSo=;
 b=pcKdAVWM8rxzKKYieI2SbtfPNdeVB5Lk49sYeA80lz/vqlyYxL9qGHC1VIU8XuZDJ/0kMkV+ft6EU+NpuJPVqS2pd8HseE+gznx9y6ZFujx81p3vTzUWEI0N8nRdykoAuUyLS/7mAtAKsvJ3kD8x1sr+78nTwHZZAu+2IXHb5FGldQj/xdgF/ALOC4EC2+VmWFCtPAIH+xVS/dgVjO1+FZ5pao2oIl7FEvgzjqcr1VCp0qcWVOcB63PmZXWuJD7VdlJtReLBmjiPgmfNtimlep8hYDkCqpqhP/RKV27Y3MJgiKYPg4pyH9EiLnDhMtiiOYgcLl2go1MKULZ93dWGIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwqpmSMGh9l+PfzIvYwQYyBpCivENE17EiTSj+kPtSo=;
 b=desBFOHHki/RQug+iMU708WCnTgGpldt/HUwmyzr7oiQb2Jf29hFu+/hr6HUK4xkCq0uXI+eg5jrSHdWxkx9pNT3a5QdWUHVM9Ussmku5ukFFoEuTkiNN3sHxP4vATfHkKr6MZChxnN4AlFjx+y4mgqeMt1/5kb86pDbusTdg6jDsmhfpu8xFbF6T1Ewn4N7O7KB6MW3dccojCfEzqVuITvErCc9tBLBTRmd5fG4W7B1jxD6ZcEkinIcQYE+ktHWSGUnwT12pkTl+rbZMchC6sMRKCl0H/EayyjFS9+wcf+NQJMnrJz7B0o7crMDBWl14EZc+eL7VXRztmQP4zqGiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAWPR04MB9861.eurprd04.prod.outlook.com (2603:10a6:102:381::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 20:34:12 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 20:34:09 +0000
Date: Wed, 11 Mar 2026 22:34:10 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Wei Fang <wei.fang@nxp.com>,
	netdev@vger.kernel.org
Subject: Re: Disappearance of network PHYs
Message-ID: <20260311203410.rio7m6nuf72hs5p6@skbuf>
References: <20260311153421.u454m3e4blkstymt@skbuf>
 <eb6edd0d-36b6-416a-bf74-676421f12f2d@bootlin.com>
 <243d5ec4-785e-459e-9129-d1e862d36716@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <243d5ec4-785e-459e-9129-d1e862d36716@lunn.ch>
X-ClientProxiedBy: VE1PR03CA0013.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::25) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAWPR04MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: ba25793e-3bcb-40d2-eca3-08de7fad8c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|19092799006|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ywjfsb73YUvDKvJjHxlYSlwcxfIGK7iJouu6mxF1vP/tDorAdVoPElZPzsOP1PeiBfqWtV7dwz786iKHs6CR6ZHTTQUMQzEwh++RJimE4IexyuJfq63Abn3++f1MVWek7/bOepunKdLsLsssOYIMcrf5OMrsyWbDs53JrfBFDywr9H3MjFYn/x352ypY2Rk1NguRx1uR5bj7mGwb6kUVGAw4HJVjoDIn1gqMF5OEoFIFkr6I2p6L8wfqtOCmYrld4S7bVGS+8Qckt1Em/OmT3eaFzWvcf5TSpyDP8Iya3OmWO/u77orYaN4JIxfvMlHZ/7a5FpjcC6jHyyenQbQlmh1fwwbzhoPLtA6pK4YRO/SxoLAJbOfXAsoNRuq6gxZLYx8+tew6EL/QUHvOHjAL5g7L70//Wh2aq5tcb/4hVlSFGm6n2P2xsiZLLJv00UzLP8bDZ1BnmwGqcQia2c4tGuvLLet6SvpQvOJ/lfFRcAfhZxw59E6N43E2s3zEnEzeFtLugR1ntT1m2u+/pKrYOesQ9E2BpvbFWX3zG6rcwfC8PDFYO5sJaGCtHOAAdLtt3+70d67+4QVuXWz4Am054rLF+kpJZ0bxEk+yMcGl/hbeP8/oUAjOnQT/9FWkewOLvjoOXxlipiURCR/2uYSv7yf1qrX3TWCCzwHttqpTwxQ3xjAuKPf2zyezw+V7sAdgdPNOKnH84iNbtiID8BGDGMiG2unGVyPhCrny//6ouls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(19092799006)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oVV3TxInA4SeXKPrzQUsvT3RYIOwOgq7w4BLh5PkUT/PJrN7Q902REWlqBCv?=
 =?us-ascii?Q?PJfnLC6BfysssXQCi4oGzhRDNv2zkCy4E/qAaXn+8xI990eyYfvvcQnXVlHz?=
 =?us-ascii?Q?kwyOX9qldPDA+ft7yIo2bBnpFE3ZXQO1fnioB9QFp6feimA+IQOIoNId4QL8?=
 =?us-ascii?Q?Fdkyc/KdI7jT4C08ZxPvFGTAnXbxdtyX8gfQPOJ4oH5c5NQv/6TiQO3OZImE?=
 =?us-ascii?Q?JvRpUcOs/lHBI7rK8T6GugzPiWgld6SLXp3yJW2T861l9Iw+siVSjiNsSKmZ?=
 =?us-ascii?Q?5p+vF4OTUDTqaBTdlrdw1fsfiwUqoIO/Ng2IlqSFHn/5sthl768qHwe6Yfcc?=
 =?us-ascii?Q?NClDGlg39GYOUXVoNpMtezPU75uC9o2qBKLl+0QD95z6E9L4AKKd90ox0pjJ?=
 =?us-ascii?Q?kK27OW9oDG4jGSwJ9/PB7njb/NWJ/EW23Xatbj/QrGiprkuSb1+l4K6+pY6X?=
 =?us-ascii?Q?seNri7QUENrI7GXmGCaqcoNsFsmP0wQaMMwKq2l6VHe+hwP7jnWy05su4En8?=
 =?us-ascii?Q?69CVq28eQzMqrq2OWrOrFprOi7oJQ7Ic7UC8HKxRlzMvO+DhmMny0GrwDlo5?=
 =?us-ascii?Q?ZlC5L1KbSVXtBxxQYNxOc9yi80l0RwvCPNNajYONsbQqAcJnOqONxuZcuC2h?=
 =?us-ascii?Q?k4uBAV+lwfcR2Nzzz73dDEpvZn0G1eItjIl+wORfdFUDspVf1oHW8JfyFJ8m?=
 =?us-ascii?Q?YdCpn3ShLeNkXi9qpTzKTFHYMbSHatt36RQVT9pywXIHVnhsjbNMNNlOnxbE?=
 =?us-ascii?Q?K9ZG7yt/a38OKCZ7EFx0g2uWj/nOSd+j7fc5NDwOKdgs0bMNNC1+NtjfzmEF?=
 =?us-ascii?Q?Umm7iMDWsn6/ty4HdzmqwwzCrBo5f6j6NMacn9NLmYHDdo6fSrJFRvU/aFtK?=
 =?us-ascii?Q?d5fwlf4Qpo+irr0qdlwsu1OUW70Xosik+NjIxG1f1KDxyg6wbSbm7PeYIBdS?=
 =?us-ascii?Q?KZxuUZh/qCGcFEHSdWjf345TW5O7B3r6QRq4pB8ttJGLRg4G2Fv1Q8b/Rp+C?=
 =?us-ascii?Q?Ji8rUvJNbhgJynKrPrHv4SNOCdmSU3H4860mJggXs2PKN2JePUPjp+2/wk0M?=
 =?us-ascii?Q?y/SP8RXTBcENmukkSxU7rUcb+9ylCU5YANnZuYKE+oErXP5/8suK/uEqIaDT?=
 =?us-ascii?Q?HfAqqtHFH/Dw2gU3o1FPaer0mcIQ1g/UQ4Jzq3Ydx7jO2UW+8Z1swV68lxaH?=
 =?us-ascii?Q?G3QCswNDGnOXeZmvoMl0siqV0oop5Fnxa4M5kub2kzpaCkGrQ4P0o7nSkSsl?=
 =?us-ascii?Q?O0tWPG2usAUw/kiF4E7n5bR70XJcI8M/6Jv1pphRiUXIQ5LO7My2JQza0C9t?=
 =?us-ascii?Q?zWLeCIGK7YODK2TM4zoz3dn599SdAh+shxoP67HD+zFlTk1ZO6f3pu9a8tWA?=
 =?us-ascii?Q?AIPuYQHfe4VGPoPiOehuuh8Q0ZjzZMKU++lFaEAeD2kM8fxd7mmWnNqCoz/n?=
 =?us-ascii?Q?LLBttHCTkBCuSWL3O6Ey98ScQygZMTI0i7MIkg5H+BA3nEvMC4uGv55XmZx3?=
 =?us-ascii?Q?asiUoHXAA7msS/YorM9qy0sBMLu272oBFu3DvnRMFd19CbfCS6PnllOrImRw?=
 =?us-ascii?Q?uz72YWrTZmwqH6vatdL1FZsd9aPNPg+pG9kh+9TTQ/0Lmp8d6/5v6p4YiWsx?=
 =?us-ascii?Q?Xerh9gCexfBzO+4e1ie74G8GyHK8ZeClvQP6DkeOpQqyRkA385Q5I9DDPm/O?=
 =?us-ascii?Q?MXyeg2wVfPNnyymUyR9LqLsmUDkJ7SLDwMVRNwmaROXCU5NzjpmpXyvwjjj/?=
 =?us-ascii?Q?d8ophRfaIzGbaZjDdOH5y7Un8jHxMK8bVNM6ORx7weulxoJJz3HKkTWHvY2F?=
X-MS-Exchange-AntiSpam-MessageData-1: pg+8xwoSl4fLNw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba25793e-3bcb-40d2-eca3-08de7fad8c51
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:34:09.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myIGrdKSUEKo3h/fhe1Iuyi4CG3VhMu2M4m6WX3ycyWQUBkEOoY8NNtT4N4jVk+cD6xW73loN9wmvNPUHFLYjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9861
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266772-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bootlin.com,gmail.com,armlinux.org.uk,nxp.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9919269FC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 07:17:18PM +0100, Andrew Lunn wrote:
> > One other thing could be to rely on phylink to handle that ? It's the
> > one part of the net stack that already handles PHY devices suddenly
> > disappearing, with the SFP case. It has all the logic in place to
> > maintain the netdev's phydev pointer without the MAC driver having to
> > deal with that.
> 
> We might want to consider the different use cases.
> 
> 1) Hot pluggable hardware, and it disappears. As you say, phylink can
> handle this.
> 
> 2) Root unbinds the device, while it is in use, for hardware which is
> only cold pluggable? Cannot we just consider this a foot gun?
> Exploding is O.K?
> 
> Is there a good use case for root unbinding the PHY driver? We should
> only add complexity if there is a good use case.
> 
>    Andrew

I do have a customer specifically targetting equipment for explosive
zones (EX-A, EX-P), which has components powered from independent power
domains that can be administratively powered down and taken out for
servicing, and then plugged in.

The requirements that were formulated to me are:
- it is known ahead of time, typically by a few seconds in advance, that
  a power domain will be turned off.
- the rest of the system must continue to run with no interruption
- the system must pick up the components after being powered back up

Their system is a ZynqMP with 3 SJA1105 switches forming a single DSA
tree.
i.  2 of the 3 switches are in EX areas, and the main switch (in the main
    power domain) must continue to run when the EX area is powered down
ii. one on-board PHY of the main switch, with an M12 connector, is also
    part of an EX area and can be powered down independently

There are isolators on the *GMII and SPI lines, pull ups for MDIO, so
electrically the boards can handle the missing components, but software
is a bit limited, and I had to figure out what is missing.

First off, the customer is OK with unbinding the driver from a device
when the power is about to go down. Linux mostly* makes no access to the
registers of unbound devices, so you can do anything to them in that state.
It also cleanly fails to probe if you try that and there's no power
applied (because probing typically accesses registers, which would fail),
operation which you can retry later with well defined semantics.
So, binding/unbinding was chosen as the simplest tool that gets the job
done.

The DSA assumptions preventing use case i. from working are that a tree
is only set up when complete (all switches present) and torn down when the
first switch goes missing. There is no "degraded" state - I had to add it,
and rewrite DSA tree probing such that each switch contributes independently
with just its bits, rather than the tree doing it all centrally.

For use case ii, the phylib code is actually mostly fine already. You
can unbind a PHY driver as long as the MAC hasn't connected to it, and
nothing bad will happen, the PHY state machine doesn't run, ethtool
operations don't pass through to the PHY, etc. The problem is again in
DSA, which connects to the PHY at probe time and disconnects at remove.
I've moved these operations to ndo_open() and ndo_stop(), and as long as
I run "ip link set swp0 down" prior to unbinding the PHY driver, things
are again fine.

*actually the EX area may be unpowered even at boot time, and in that
case, being that MDIO is an enumerated bus, the kernel will fail to
create a device for the PHY in the EX area. That is completely distinct
from having a device with no driver.

We solved this by disabling PHY enumeration by using an
"ethernet-phy-idAAAA.BBBB" style compatible string.  This tells the
kernel the PHY is always present, so it will create a device for it
without trying to access any PHY ID register. When we apply power and
then run phy_connect(), it works.

My involvement with Wei's device link patch is actually just that I want
to proactively protect this use case from breaking (and to upstream it).
Of course a device link between the PHY in the EX area and the main
switch would throw a wrench in the whole use case ii. This makes it a
bit fragile, given the fact that, as explained, device links seem pretty
common sense for single-port NICs. So it is in my best interest that we
have a clear model where unbinding the driver from a PHY doesn't "explode"
(no reference to EX areas intended), even in uncontrolled situations
where the netdev isn't carefully disconnected from the PHY first.

