Return-Path: <netdev+bounces-286556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEpEEEWfAWpKgwEAu9opvQ
	(envelope-from <netdev+bounces-286556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:20:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06250AC26
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8E7E3024031
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B73BA220;
	Mon, 11 May 2026 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RP9TYwqy"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F7337D101;
	Mon, 11 May 2026 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490481; cv=fail; b=Zesp7BVZTEH3r2FR+9aRy1OunXj7zGsyN5WyujdVMMrQ782LLzHGbZ0TqEWznXOKOmK9snKVfgyn/TneRjwSCIEXlx69TCbvuJVybkfBh6J7aQuk6LkM1Vcnqpv0tT+L0BE+JE2RuTqqrB+OL4ZGCGTsqrp+/JQ1rH6HhpK0jU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490481; c=relaxed/simple;
	bh=Ddl2gu7Y5KYpTuhMSmMk1D+KHv1vkOZ4XolFgVCsdbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L2Hs3DnKNRKq4cW39QY0YEZk0rYR3VrJSYHuraKO+O10yuho+KidypF1CrSLyQuhTM3g2fZafzlW3xxhQSCH8biUMrzPWG+rjRqH55DXAdY0oNWg8pjsWQs9AC8+APtFLDzUPOmHRq+KKeCvLKCFpWqyCdQoHrQnhj0fc5M95QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RP9TYwqy; arc=fail smtp.client-ip=40.107.159.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2qQ/otQYY7p5UFNmnCZz51fjUTKiuJeWCJXZtIAs4vqsav+afSkLSA8uh3OktQ24PWP4a7xpCttumq862jAwoFw9QUexgxNIM6dh/DwjoIQbgeUFomSiLIh7qAcVPPOfNeMrItFAyX0JXyFh5iV5qaoPrhIpFLo7uU8FdSGblLqNXk1tX4yZehZxI2gcRMZmyAgDVkM9C65kElAz9XkyJDz50j3KK17U5qKiZc2EFGJjyYojukbfPxZhWCx9NLcRTXSCG3bfRfkDzlPMA8iKuwrjAmUUJ9VxZU5AFbhKDeO/XgbA7BrmJhDDKqENmHB0RZAYAYME9UkSgYB939g1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMSBGnUEG0HMANx4DS9Ckfs66YuOmFxtG8EJgsRK+oY=;
 b=rOPzSMIBDeTirr4QqodKsprER/v7i0buOVnFKy0yOmo100ppj46Jwe0VgSJBGNPs/ZsiFbbKIMCl2RzFF8l2JHgyQMBMJzAy1occQKGqFi8T5OGvPiZVEUU+B1n0iDEXWZ5Fr2M85lowjmfKlG8/8y854xr6N7VzA7huOjwa2qnGD/K7t2zH7PWPNNf0jHstAAVJzKuJivWwzF0+2q9lVoXn+mxBv5xndBkLuJOS9hx9cr1LlGGICEJ5JiDIwiM5z9mO/yQ+UZm4UD7vJ8bWLqRr0lKIyqh3wQD8dfJzEGPjjEz8ex4p9FoNQqsFPoDj2q7+igp7kBwfghL1iXI/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMSBGnUEG0HMANx4DS9Ckfs66YuOmFxtG8EJgsRK+oY=;
 b=RP9TYwqywWZZOkYhBOqPiepwKDIIdVspKTR56gJ54Qwqgx+2hHSo6Zlhs55Yh8fkipI4sgZbb+5My68mwfR9l/qi1HlGWK/EzSwoM5GWGf+sUofy6rltO/mjBteau2I5OsroRIKEU71SuxXN3V1bfd4QqbEU2kFjJ7VeggiH5R/c5UgiN2UVL3aImil87/+lHpNb84JAi3d9nSM96ssLs/82kTscRJ910EEHExLkfhZaZ44QQLDSBIGFcBkQuctivT02mVUzK0FIDEYx4/62i5nXbIBGQqcZ0Y+zV3teU0Uw52Sp1lxJLubO4jWojvOX5qmwaeEYVFq0cHleUBAryQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DU0PR04MB9494.eurprd04.prod.outlook.com
 (2603:10a6:10:32e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 09:07:56 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 09:07:56 +0000
Date: Mon, 11 May 2026 12:07:52 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/13] dpaa2-switch: offload port objects on an
 upper bond device
Message-ID: <nzqag7u4ebk4csdkgofs2zmyyt6sdgeu56uzkzloecd3qc4xyu@32gck2hubytg>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
 <20260506151540.1242997-11-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506151540.1242997-11-ioana.ciornei@nxp.com>
X-ClientProxiedBy: FR4P281CA0316.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::16) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DU0PR04MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b8e429-70e2-45c5-d6d8-08deaf3cca28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LUZP+DWmH1DuVM3K73Nsx0cfx06emjfT63t12sKiDp0pL/mVIHF5h2gnsL+lOF3XH1tT3cd9ye9he1nEsNTooqPaN1UTvcQbqfXtD52r2czL7533PV2EomVX3IKl8Mcr0Vi6PzVmZwa+4ti38sFJsHyi75AgaQjoqWraNnA70+NVQVIhp21ALOGqcyKY89e400FKyvhzHoPLQaMbVFzJ7NjDLUf7+2Z3fDu7OvdRB3rb1A2G97VnWsi7Uq1NVKUqOFj608Gx+9OJvRcngJhQO9OMalX9bf5rG3ZsLQtE7hbMNjwKRBzhNKmvHTiRVDIYXWh8tleq+sZvGazDpm85uGskvaUK4Xf/ui/F04LpdsUqXgASwAiDeHiIzHxvn/HZm4p012K8xoUxim0ebnRDuHCjyiZ2kHeMBbeCQQSK/YyTMNlBt44vvmqxLjMIMy961rpjC26LWWc/K0kELEslOJUyNE/eQeEbRepCjCyxT4ho90ZU5sCNYcOKvxHkty6pR86YXPC/Ng8O7lsbxnlQx2oF0kk5OM5KKyRR/KKyRL0+RHwtUyAaspXVDbDNUGZOMQxAPENAAIyijIa9fLSo12pytQFCZiqE9PoF07jIv8rGKxFqxFgqeK8l8D7I6+BeNZ2WzOt/p3GUxF7LxB2cU2s8xMOBFHmzsr4rjvkBKtbzvKKbpbVyL9OVu+lqpxTy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PPfwTtG0FaeO11unv2A5qascdmNyKsQyvTDcGvzSJpom76pAcC69XSNPDMnA?=
 =?us-ascii?Q?sbr1w8Lh/xkL7nBahpBO94VHGIopxwC1Omqa+wRxL9UHnLRCDCZxbeaL6wbd?=
 =?us-ascii?Q?Rdr4ThC2bda1dxMDxkAKgnrARu/P+vLTYAz+OO5jEYFnrt+CtF0JhPcWEjuL?=
 =?us-ascii?Q?MwUZbcYbHkjsCbk5DhLh/GSKAzErO0tlbQwPZzRBENuLZAixyGq1lCgLKf+e?=
 =?us-ascii?Q?5z6rcFtE9kTpQSJ0IyBr3eboY9ewVChSxq5Bb/qXUvwUbXVPO91cL5goIF12?=
 =?us-ascii?Q?j03GaxtByDG0INQONi5kyDPKRmfRCMTwG9bg5Es8Kt3m0JAIRPqFlNIFAuBO?=
 =?us-ascii?Q?DH7gWl+ORHw1pqSuGpN7h1WkJqsQFWvtPaDDs7vsP+I03SuIRK6YBOAj9mAR?=
 =?us-ascii?Q?KMmXz2WTOgtPGVIY8Vn9kFEqMjXWha4n3MaopCReWMO0NESACjzn80+hO1/+?=
 =?us-ascii?Q?+4y2EcM78k8FdEsHXPDpwNeG9t8nO46eX5OrIUh8j5VaWp/+FQyrj2tcKtAe?=
 =?us-ascii?Q?/+vkA3PgmJD8zvOVF0LPC8Pv5P7MONo5uXxe9smLOe5j3stIqbkiVVhgPP4F?=
 =?us-ascii?Q?qctImg6wjPJLW/VVqwAqvPqa52+FPOAAJ/c30cOronqEdLDeKtSIzDC8heOO?=
 =?us-ascii?Q?80zXl79JWw51LqdiMwv6LhXxMXYq85+hXKRaaDY2H7G2hp0MYQbVugl5JXL/?=
 =?us-ascii?Q?PUsWz6VnzJCmfqcU+ViIkpYSvT4xLEbIpxjM2YJmgH9DLtQi9TTipH+gzsbg?=
 =?us-ascii?Q?KoS0IqRvitoajl0sMOJcwJ976Sy4E9OOuGZJ3dGKlyQkhB6NZgOaDtQEcBXv?=
 =?us-ascii?Q?RdByOi0u+UYuBEaDp4dbm0/XXHBykVZWl54gr8Gw63E9J649XOrXpPvXK1BX?=
 =?us-ascii?Q?3qcpXt/AQS3dck5vV1FMui3pG0STvxaAfjncVoC2wQ25ZFdi4Vs0Z3mqNjRd?=
 =?us-ascii?Q?7N7vIuIR72cuU7VrlOLTfJ3N2d72jjNayd6BaGULBRTQ2NLIXvZ61t8qAjg2?=
 =?us-ascii?Q?74gsWEJoV0WpbSpqD8r55LSZclfcQ6B0P2D+5CnZjxzToRdYKWhdpdv42Sji?=
 =?us-ascii?Q?6rwkGC7oQsVN8r8iTYZRNcTHdAxMeTzlner9jPDUn2MGqB5yd2wnjR0vENFw?=
 =?us-ascii?Q?Thn8KdkGYuoCLqWC4gEeKLeMuVRGu2dq9snapX5nzK4tyAvN7CvVldhrIIyH?=
 =?us-ascii?Q?rA/2U4EOwsru3ztGOnYgmWjurKMV/LSjkj1Fl66MAJKGdZwwTrF6kuECJpQr?=
 =?us-ascii?Q?iGt6c4lKBh0Du9o4hOtFUoGH0dboYIF4MtjV6JBhqpXiIp/pyqJuUKHRCNIJ?=
 =?us-ascii?Q?9YYdDUibJi7qXp2eGDKJrMK7THB8buh0EZgvbvWDMZrrc8wzDQIePw8JpCvA?=
 =?us-ascii?Q?qt3DO3udvY/RCcYLrnYMvI4cKZi9wMD1Ev9F+BWmh7+HHfZq7PJTac0OXVyt?=
 =?us-ascii?Q?Cz5x2M+TPa1tQK52aIDeQOw5gI44OQQbddAJ2fXlFldzho2Mrr7s2tjQVImD?=
 =?us-ascii?Q?fUwsnJorMAt9J2BpIoGHqol52ZnF78havyssp2387GfQBRpkW6mrnJONt7Cq?=
 =?us-ascii?Q?BpZaMdxoHIEN7kKQHMV+KhyWRm1ywqtKHwMbv8m5SvzlsBMZdwrf0z0c+GJi?=
 =?us-ascii?Q?nt9b817+zoQ5GT9Xo5A/Gzr8jFAzT2yWYD1bi8E4fwLEBjfYf794y+NEZiJ4?=
 =?us-ascii?Q?LkXgOS8F8tXBjkB8jkadZIWiv+Xe4Th0BLxZlKUY2kX6W/fD6YcmgTEcFBxp?=
 =?us-ascii?Q?08MtZiyySA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b8e429-70e2-45c5-d6d8-08deaf3cca28
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 09:07:56.0024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNjZANS6tpq8muNpZ9ukFVGJlUZvdDLstgjOF2/brmhWd8PL2qEMh4TSufkEuFH/3DWueIY96/ttHn1zVGVIZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9494
X-Rspamd-Queue-Id: 5E06250AC26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_FROM(0.00)[bounces-286556-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 06:15:37PM +0300, Ioana Ciornei wrote:
> This patch adds support for offloading port objects, VLANs and MDBs,
> added on upper bond devices.
> 
> First of all, the use of the switchdev_handle_*() replication helpers
> is introduced for the SWITCHDEV_PORT_OBJ_ADD/SWITCHDEV_PORT_OBJ_DEL
> events. With this change, setting up the 'port_obj_info->handled = true'
> is not needed anymore since it's now handled by the new helpers.
> 
> In the DPAA2 architecture, there is no difference in adding a FDB or MDB
> which points towards a LAG port. Unlike other architectures, we do not
> need to populate all the possible destinations which are under the LAG,
> we only have to specify a single queueing destination (QDID) which
> represents the LAG. This all means that handling of MDBs in bond devices
> needs to have refcount mechanism as with the FDBs.
> This mechanism is triggered by calling the dpaa2_switch_lag_fdb_add() /
> dpaa2_switch_lag_fdb_del() functions which were added in the previous
> patch.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 66 ++++++++++---------
>  1 file changed, 36 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index cce0af47ca07..17a7a64064b5 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -2060,7 +2060,11 @@ static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
>  	if (dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
>  		return -EEXIST;
>  
> -	err = dpaa2_switch_port_fdb_add(port_priv, mdb->addr);
> +	if (port_priv->lag)
> +		err = dpaa2_switch_lag_fdb_add(port_priv->lag, mdb->addr,
> +					       mdb->vid);
> +	else
> +		err = dpaa2_switch_port_fdb_add(port_priv, mdb->addr);
>  	if (err)
>  		return err;

Sashiko notes:

	If dev_mc_add() fails further down in this function, the
	rollback path unconditionally calls
	dpaa2_switch_port_fdb_del_mc():

	err = dev_mc_add(netdev, mdb->addr);
	if (err) {
		netdev_err(netdev, "dev_mc_add err %d\n", err);
		dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
	}

	Does this bypass dpaa2_switch_lag_fdb_del() for LAG MDBs?
	It looks like this could leak the dpaa2_mac_addr structure
	allocated during dpaa2_switch_lag_fdb_add() and leave the
	software lag->fdbs list out of sync with the hardware FDB state.

Yes, the cleanup needs to also take into account if the port is under a
LAG or not. Will fix it.

(...)

> @@ -2178,9 +2190,10 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
>  	if (!dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
>  		return -ENOENT;
>  
> -	err = dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
> -	if (err)
> -		return err;
> +	if (port_priv->lag)
> +		dpaa2_switch_lag_fdb_del(port_priv->lag, mdb->addr, mdb->vid);
> +	else
> +		dpaa2_switch_port_fdb_del(port_priv, mdb->addr);

Sashiko notes:

	Is it intentional to drop the error check for hardware FDB
	deletion here?

	Previously, the function returned early if
	dpaa2_switch_port_fdb_del() returned an error. By silently
	dropping the return value, the driver proceeds to remove the MAC
	from the device's multicast list anyway, which might mask
	hardware desynchronization regressions from the caller.

Yes, it was intentional. I think there is no point propagating such an
error on the remove path.


