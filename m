Return-Path: <netdev+bounces-303235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dRhmJVbSQ2r2jQoAu9opvQ
	(envelope-from <netdev+bounces-303235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:27:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E5F6E56D4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:27:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=I2NlxxOA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303235-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303235-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A836304A141
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE5425CE5;
	Tue, 30 Jun 2026 14:23:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C952374A07;
	Tue, 30 Jun 2026 14:23:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829399; cv=fail; b=kbnPrGYKMyiOuA5vQxbzF/tpuQ/7LllND7CF3ilJRF273hvM0PKspHSJAPLEalQ/xWDIuZJPrZTJuGFmL1CK7O3nEv5kjMBQiK1VmTq7AHDfBKhIyN/IwEALuHn3dMeKfyGp6PeV66zTKLnUa2NJ3LrIAkQbqkxqBN2HMt+3feo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829399; c=relaxed/simple;
	bh=tRYLQhYw42SnhYHnmMRUIt6YdAm9dNaw/EK54yKQsbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AWeqR5dI10P1tQgw8sS9drqPoo9sx2C5M++4TldsOg1HAMYn+ErQJfGC9JNVO1wHc0cQykV3YHLpAk2At+wjQi7v9RJD4j34mzle6iUQpYXZ+5Pj1Hv/64Q+9vXBC0fwFvamSt2RqlR0O4chOmb3dHPwOT2SkuD7wza6GdrpyHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I2NlxxOA; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpdlYYcOASsDCKgS94ZathH9UeAylZlXzJerAnbd4JWFGErb77fYKx3zOSBAadfb1mXkIhazSlsF74DmYyAXFo2AoFti2M4F1cp7DxFC6JguAn102b9gz6OfDw7NEQ19AgPG8E9e8X9SYDfHh13L8pPeYH73wGc+Z3rQOM5wHGW0m9jXgdgpl4NzjowWO4/tL+T7iW4lIK9fK9sLIGbvRwIlT1apGvLnmhdFttEfTY3JeUSFYfvvzTVFzba8oVjl0N1biCkG3yXajBAKMIgW7oMrfw/o9PuSx31Jx0HAbFGZGncpYt9BaNe8adZ5Tz0S6AlVL/PU/zD4mZefH2HJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai4I/RXo3A5+/36dJwQLvie4R1JYPQehccICP3VvY+s=;
 b=Ab3MtpEdAl18Y+EBIA6YehqVvDD3kFpwzjkHrLcVsfshTZdk5AVWjKhAyWxeHEDfef4ovuaTn/qbmnoB+6a5idbMXihV6Jn4dp/6I15vkD/O8gQcVExYm6+d8fRXxfXkolAktN//iyHnWm5Tw/LPDCmczYCdufTlOMV7puAT0Jn2cEfVsW8h+RZ885ie/ByxRZS4i2Wf0KsveM4DGlgFh1AluJofV5lRM+BlJTGOlhb/4TywMiuZSPTwLMIBLqoaS7LeB8UQK6Q9971amv5nh5lhjvOuolGkLlxfAtnJp6Z0l/9ADfBedxqgk01DudjF1wG794UwE0ZE3If/5iuz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai4I/RXo3A5+/36dJwQLvie4R1JYPQehccICP3VvY+s=;
 b=I2NlxxOA0TbhEy+nxidvqXwQb8r5i8UDVxmbHOTBrvKB0l1JznhSBBttJZ+dS8RaQNqm+KwALdO8xfA/uKNzwyYCi4YQ6wuSc0L4gLm34WisaWOYESpnt+CZEV/5mkyy/Df1mIMqgnAB+zg38gK8CvFkdKffhsJ/D5tVEva7/RgAK9x5Npa9TGwBoGpviLpsBsG0cVts0b7TLr2/6Dmpo/Ehsvq5U+j3QZmJ3TCqe17++MgUF+l74hyUOJezJR+a/E90Ws+awFEGHiCz6TyyMiJYYCeXeXUfbB7Xwj8+vlhcgVCwujh/hkYfUTedssPwA0o2w958iwXxFuN4V5mWXw==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by AM9PR04MB7538.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 14:23:14 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 14:23:14 +0000
Date: Tue, 30 Jun 2026 17:23:10 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 09/13] dpaa2-switch: add support for LAG
 offload
Message-ID: <td7c44fw6in3ghlgj5rlkmlcv5kfekpopwuwykfcw27syarznj@ehdqzzgnxfge>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
 <20260629112309.154328-10-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629112309.154328-10-ioana.ciornei@nxp.com>
X-ClientProxiedBy: AS4PR10CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::15) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|AM9PR04MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d6b554-52d0-45d7-4d44-08ded6b31f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|23010399003|18002099003|22082099003|3023799007|5023799004|11063799006|4143699003|56012099006|6133799003|27256017;
X-Microsoft-Antispam-Message-Info:
	275u2VYV1qYiMQeDJye1XCtRywq8tBDTOrmtrSDhfVGq/11kTi0X/Iyhw0h0PF9iajx/QBgCvVU4xUOTQ5UT7a2FYMT49r5+AMtMoltK+vrwlTDP5B5J8hTQ5Ek9NJtLDAHTEkqodQ1mVl5kAzcphKaHTESQj2RFwpwc90KiKujNGnuLN645qWGTiUb/nsdaG5kwBTj/xi1f9/jT9nY1P4VgByfoL3oFpMkNbUUn3ie0Z7kE2R+2NGt97LGHZaqrZ1uaeyUqofcvt60Vdy3i7Cvi1BdG/1lNHzunLkI7KtqNyLbWTE9x9Sh9uozeBReBDm5ojkfzK1Kd3hOFUUyAtuz9cRoeNjjdp6ZCdh3iBAPy6kIfG8ltxbDs/TmM7jKfKXF6p2VvyGveYr7LFOzccathOb0Opl6MKtJHmYNnQrB44KzPyKM8fcrop2xZs0pUM0emZq2Lk8UganeMUbcaZYhFOZf2+6cYcRprXiJJ4lDUYMG2C/362/GDgvS9/eLm2k49yvCvFkMpTZBXd7saz5q5rGnckimHcPJO6znc03Ikci3Zo9jbKxFeVs5pDgpvDf3O/JY+zNTPlEJU9t5CmoS9n6xP/t4ODAROJv1SpYe/jZhGRqn6nbkCbvGbCYu//tawAcM/6EhnEp7XZIqgQ6ycnfQLpDZ+xpQD8qmfGMr6w6f890UK3XzGbbwvaYm0dvfmHA90hUVdNBE8X0FRvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(23010399003)(18002099003)(22082099003)(3023799007)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gRfjY6ySizkhl1RrcrFAc//NYduv84Mke+fsREIVupM9L7Du8Nm/1G4u54eF?=
 =?us-ascii?Q?J/bo1rDou7NMUpdOSmgCVJ6cx+2u+Gx/d/fRXjWVVtckNIPTBwJxUiN2dhDv?=
 =?us-ascii?Q?RXILRoYa7MsTG9RvMgAjIPQ/kDg2j0jrlCGtFSIaK/NwM8uws5eQnQmbCxzx?=
 =?us-ascii?Q?uufBKNVc7pqNB2EviVx1gEoF3CQe82e9MVfWLYgKoGpzEEynRIrnXyXeb/7x?=
 =?us-ascii?Q?a41PcAJuWdMGyeKtNVJOzIrq9BsuTq15h2q8yUZWo8nkcu/Z7HY9dNNikgYP?=
 =?us-ascii?Q?D8lnOXWfeSFQtvE1R8O+1qz2MvEo0/ZQ0FTDqO87cInJkajKpvh5N6wPVN1M?=
 =?us-ascii?Q?hfPbojkGsUI5l8DErmyEojE6r8BA30X7qxXPAvEwRtIT8/JORebJvKooaPCo?=
 =?us-ascii?Q?eI3FT6c5burrAwbItUmYDZ9fuWonWxDrnGxC+Kkyi+i+TtRBN+MZ1vcGWVPe?=
 =?us-ascii?Q?Oo8w+ToT5zLfVGQ9di+AGozVVqimEA9uT+ugyAx7YipxfUF+WmrTNpIGIE6N?=
 =?us-ascii?Q?ml+cv2jbcfjbOjnOIhe01AkojVBXM9p4AhJOtGjIhaSJNn/dzMWTwVwT32gQ?=
 =?us-ascii?Q?ekF+4JPN8BOG9W9NFxtSSUwIGNvNeejn3ZqrRFXfNoflbd9jAUP0tRCDB2X3?=
 =?us-ascii?Q?qxp3pzzFhMPdJYpXYFKuZMDpb7NWym61IItdzhxKZP3NSNbtZslOCbszx0Tb?=
 =?us-ascii?Q?yV993VD/JOs3GwaDfIrQW1HwQfxC0wys0p+aU+D+lK67vlIJzAor+Cm2ake5?=
 =?us-ascii?Q?oCtf1i6Zz2a2Aczg99/i8ijjyFYGBlB2k4QHYjeqHnuC7hjgtMwFJ/XSKSyR?=
 =?us-ascii?Q?0V1EuLc3PLDjzhasdE06lIzNlG9NYgNZu90qEURq/+a85DbfKzp4sCGJl4md?=
 =?us-ascii?Q?Z8Ci/XAHOz2MMiuhZvP+qQz876aTyflEnEYI/WU8s3t3MqIUGEOvBAhhJoRY?=
 =?us-ascii?Q?ihwYWK8p+j4BfOXYEl2Ahbf9+2gkG/pKx2tbBJE6K2IHIEHwIKUPDk9pPRSo?=
 =?us-ascii?Q?BbsxV/dOtTsjAws4nPgKRsLgvHY3kOT1qfruDMxITGxVk7Sv58zR+PiEHNfZ?=
 =?us-ascii?Q?NgJH4ozapqxobzhKGEAbXxgFIGKvP2dUTfX4Nx1jlO5EVkDvpgt0yyG0T9Wq?=
 =?us-ascii?Q?bs9VMNGjYuvQV1B7WyyqcXnF363TWr4bdahghRTSMAyuhdWNa2yXB6mtwz5D?=
 =?us-ascii?Q?lqQP6srcWgGUxkvTwQS10nxz8P3Uh2NbWLoTWhkCgHiWGqVGj2aXDCBl2u2B?=
 =?us-ascii?Q?R6iShwvSdSCzEeclrYtUCwd8zJWxAuNb/bDvK2LkFp4bJGBPHhGfOOM30aiO?=
 =?us-ascii?Q?xRcf/oOzHBc6/ciYNuHUwyuMicDvsCsmO+n+zodRY7i5iR5ZN6FC7UbApgLu?=
 =?us-ascii?Q?7gXlUe3dLn5PxKkVWAtHjqdRY2qvA/RBZJK9Hs3UHdoJ604TPm8AK/c4dryk?=
 =?us-ascii?Q?K/hfIcMmJMyCAa6O+Hr+qLjefrA6p4iBBKoWGD3prbKgj4UCFpavBOpXGbbk?=
 =?us-ascii?Q?j1X16G1sMKj6XfEz9ca9ktCSoh/KQG0hexmo+O9UJDV1UkXzoAmeNn5qNTc3?=
 =?us-ascii?Q?kgsor4Q4SHgpxmjn+RZzhwn1ikkyMtYxeCnNXdSrAv9TGU3RrJ23ul8e7aJd?=
 =?us-ascii?Q?mRQLAOzYssV4n3eSwYpvCC4JHU/UVDakyIigA+/Kv1IELSYRNdCwgQVygTHa?=
 =?us-ascii?Q?+1lycW0wUfPQT2yJP0poLgNZ1CCw62D7z3RUWI6YUN8DaYef7ZOb7ttEjL8m?=
 =?us-ascii?Q?b7TmhERRiQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d6b554-52d0-45d7-4d44-08ded6b31f32
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:23:14.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDcKYXDx5JEoXQvH8AWcuhf2jdNE4QJeUTx350IcoqD7zyaR+HoTibgficJwArQGa5PNURtLeJxJScblEZVSyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7538
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303235-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,ehdqzzgnxfge:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29E5F6E56D4

On Mon, Jun 29, 2026 at 02:23:05PM +0300, Ioana Ciornei wrote:
> This patch adds the bulk of the changes needed in order to support
> offloading of an upper bond device.
> 
> First of all, handling of the NETDEV_CHANGEUPPER and
> NETDEV_PRECHANGEUPPER events is extended so that the driver is capable
> to handle joining or leaving an upper bond device.
> All the restrictions around the LAG offload support are added in the
> newly added dpaa2_switch_pre_lag_join() function.
> 
> The same events are extended to also detect if one of our upper bond
> devices changes its own upper device. In this case, on each lower device
> that is DPAA2 the corresponding dpaa2_switch_port_[pre]changeupper()
> function will be called. This will start the process of joining the same
> FDB as the one used by the bridge device.
> 
> Setting the 'offload_fwd_mark' field on the skbs is also extended to be
> setup not only when the port is under a bridge but also under a bond
> device that is offloaded.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v4:
> - Add a defensive check in dpaa2_switch_port_bond_leave() for a NULL
> port_priv->lag
> - Extend the dpaa2_switch_prevent_bridging_with_8021q_upper() function
> so that we prevent a bond device with VLAN uppers joinging a bridge.
> The restriction is related to VLAN management in terms of the FDB which
> can change upon a topology change. VLAN uppers can only be added once
> the bridge topology is setup.
> - Remove all FDB management from the bond join/leave paths. Decided to
> reconfigure the FDB only on bridge join/leave since the FDB determines
> the forwarding domain and when a bond is not bridged, from a
> configuration standpoint, the individual lowers can be viewed as
> standalone.
> - Moved here the update to the dpaa2_switch_port_to_bridge_port()
> function so that the LAG state is taken into account.
> - Add a new per LAG field - primary - which is used to keep track of the
> primary port of a LAG group instead of determining each time we need to
> use it.
> - Set 'skb->offload_fwd_mark' only when the port is under a bridge.
> 
> Changes in v3:
> - Fix logic in prechangeupper callback in order to not call
> dpaa2_switch_prechangeupper_sanity_checks() on !info->linking
> - Fixed up the logic in the dpaa2_switch_port_bond_join()'s error path
> so that the FDBs are cleaned-up properly and we do not end-up with FDB's
> leaked, meaning that they could have been marked as in-use but actually
> no port was using it.
> - Mark the port_priv->lag field as __rcu and use the proper accesors for
> it. This will eventually become useful in a later patch when the lag
> field will be accessed concurrently from the NAPI context and the
> join/leave paths
> 
> Changes in v2:
> - Extend dpaa2_switch_prechangeupper_sanity_checks() with
> netdev_walk_all_lower_dev() so that checks are done on all lower devices
> of a bridge, even for the lowers of a bridged bond.
> - Manage better the default VLAN on bond join
> - Clean-up the error path in dpaa2_switch_port_bond_join()
> - Call dpaa2_switch_port_bridge_leave() in case a port is leaving a bond
> which is also a bridged port
> - Update dpaa2_switch_port_bond_leave() so that in case of any failure
> the driver tries to cleanup the LAG offload configuration.
> - Call switchdev_bridge_port_unoffload() in a switch port is leaving a
> bridge bond device.
> ---
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 473 +++++++++++++++++-
>  .../ethernet/freescale/dpaa2/dpaa2-switch.h   |  15 +-
>  2 files changed, 476 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 3472f5d5b08a..949a7241a00f 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -51,6 +51,17 @@ dpaa2_switch_filter_block_get_unused(struct ethsw_core *ethsw)
>  	return NULL;
>  }
>  
> +static struct dpaa2_switch_lag *
> +dpaa2_switch_lag_get_unused(struct ethsw_core *ethsw)
> +{
> +	int i;
> +
> +	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
> +		if (!ethsw->lags[i].in_use)
> +			return &ethsw->lags[i];
> +	return NULL;
> +}
> +
>  static bool dpaa2_switch_fdb_in_use_by_others(struct ethsw_core *ethsw,
>  					      struct dpaa2_switch_fdb *fdb,
>  					      struct ethsw_port_priv *except)
> @@ -2042,9 +2053,15 @@ static int dpaa2_switch_port_attr_set_event(struct net_device *netdev,
>  static struct net_device *
>  dpaa2_switch_port_to_bridge_port(struct ethsw_port_priv *port_priv)
>  {
> +	struct dpaa2_switch_lag *lag;
> +
>  	if (!port_priv->fdb->bridge_dev)
>  		return NULL;
>  
> +	lag = rtnl_dereference(port_priv->lag);
> +	if (lag)
> +		return lag->bond_dev;
> +
>  	return port_priv->netdev;
>  }
>  
> @@ -2193,30 +2210,53 @@ static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
>  					  false);
>  }
>  
> +static int
> +dpaa2_switch_have_vlan_upper(struct net_device *upper_dev,
> +			     __always_unused struct netdev_nested_priv *priv)
> +{
> +	return is_vlan_dev(upper_dev);
> +}
> +
>  static int dpaa2_switch_prevent_bridging_with_8021q_upper(struct net_device *netdev)
>  {
> -	struct net_device *upper_dev;
> -	struct list_head *iter;
> +	struct netdev_nested_priv priv = {};
>  
>  	/* RCU read lock not necessary because we have write-side protection
> -	 * (rtnl_mutex), however a non-rcu iterator does not exist.
> +	 * (rtnl_mutex), however a non-rcu iterator does not exist. Walk the
> +	 * entire upper chain so that a VLAN device stacked on a intermediate
> +	 * bond is caught too.
>  	 */
> -	netdev_for_each_upper_dev_rcu(netdev, upper_dev, iter)
> -		if (is_vlan_dev(upper_dev))
> -			return -EOPNOTSUPP;
> +	if (netdev_walk_all_upper_dev_rcu(netdev, dpaa2_switch_have_vlan_upper,
> +					  &priv))
> +		return -EOPNOTSUPP;
>  
>  	return 0;
>  }
>  
> +static int dpaa2_switch_check_dpsw_instance(struct net_device *dev,
> +					    struct netdev_nested_priv *priv)
> +{
> +	struct ethsw_port_priv *port_priv = (struct ethsw_port_priv *)priv->data;
> +	struct ethsw_port_priv *other_priv = netdev_priv(dev);
> +
> +	if (!dpaa2_switch_port_dev_check(dev))
> +		return 0;
> +
> +	if (other_priv->ethsw_data == port_priv->ethsw_data)
> +		return 0;
> +
> +	return 1;
> +}
> +
>  static int
>  dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
>  					  struct net_device *upper_dev,
>  					  struct netlink_ext_ack *extack)
>  {
>  	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
> -	struct ethsw_port_priv *other_port_priv;
> -	struct net_device *other_dev;
> -	struct list_head *iter;
> +	struct netdev_nested_priv data = {
> +		.data = (void *)port_priv,
> +	};
>  	int err;
>  
>  	if (!br_vlan_enabled(upper_dev)) {
> @@ -2231,6 +2271,70 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
>  		return err;
>  	}
>  
> +	err = netdev_walk_all_lower_dev(upper_dev,
> +					dpaa2_switch_check_dpsw_instance,
> +					&data);
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Interface from a different DPSW is in the bridge already");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dpaa2_switch_pre_lag_join(struct net_device *netdev,
> +				     struct net_device *upper_dev,
> +				     struct netdev_lag_upper_info *info,
> +				     struct netlink_ext_ack *extack)
> +{
> +	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
> +	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +	struct ethsw_port_priv *other_port_priv;
> +	struct dpaa2_switch_lag *lag = NULL;
> +	struct dpsw_lag_cfg cfg = {0};
> +	struct net_device *other_dev;
> +	int i, num_ifs = 0, err;
> +	struct list_head *iter;
> +
> +	if (!(ethsw->features & ETHSW_FEATURE_LAG_OFFLOAD)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "LAG offload is supported only for DPSW >= v8.13");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (info->tx_type != NETDEV_LAG_TX_TYPE_HASH) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Can only offload LAG using hash TX type");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (info->hash_type != NETDEV_LAG_HASH_L23) {
> +		NL_SET_ERR_MSG_MOD(extack, "Can only offload L2+L3 Tx hash");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!dpaa2_switch_port_has_mac(port_priv)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Only switch interfaces connected to MACs can be under a LAG");
> +		return -EINVAL;
> +	}
> +
> +	if (vlan_uses_dev(upper_dev)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot join a LAG upper that has a VLAN");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
> +		if (!ethsw->lags[i].in_use)
> +			continue;
> +		if (ethsw->lags[i].bond_dev != upper_dev)
> +			continue;
> +		lag = &ethsw->lags[i];
> +		break;
> +	}
> +
>  	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
>  		if (!dpaa2_switch_port_dev_check(other_dev))
>  			continue;
> @@ -2238,11 +2342,229 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
>  		other_port_priv = netdev_priv(other_dev);
>  		if (other_port_priv->ethsw_data != port_priv->ethsw_data) {
>  			NL_SET_ERR_MSG_MOD(extack,
> -					   "Interface from a different DPSW is in the bridge already");
> +					   "Interface from a different DPSW is in the bond already");
> +			return -EINVAL;
> +		}
> +
> +		cfg.if_id[num_ifs++] = other_port_priv->idx;
> +
> +		if (num_ifs >= DPSW_MAX_LAG_IFS) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Cannot add more than 8 DPAA2 switch ports under the same bond");
>  			return -EINVAL;
>  		}
>  	}
>  
> +	if (lag) {
> +		cfg.group_id = lag->id;
> +		cfg.if_id[num_ifs++] = port_priv->idx;
> +		cfg.num_ifs = num_ifs;
> +		cfg.phase = DPSW_LAG_SET_PHASE_CHECK;
> +
> +		err = dpsw_lag_set(ethsw->mc_io, 0, ethsw->dpsw_handle, &cfg);
> +		if (err) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Cannot offload LAG configuration");
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void dpaa2_switch_port_set_lag_group(struct ethsw_port_priv *port_priv,
> +					    struct net_device *bond_dev)
> +{
> +	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +	struct ethsw_port_priv *other_port_priv = NULL;
> +	struct dpaa2_switch_lag *lag = NULL;
> +	struct dpaa2_switch_lag *other_lag;
> +	struct net_device *other_dev;
> +	struct list_head *iter;
> +
> +	netdev_for_each_lower_dev(bond_dev, other_dev, iter) {
> +		if (!dpaa2_switch_port_dev_check(other_dev))
> +			continue;
> +
> +		other_port_priv = netdev_priv(other_dev);
> +		other_lag = rtnl_dereference(other_port_priv->lag);
> +		if (!other_lag)
> +			continue;
> +
> +		if (other_lag->bond_dev == bond_dev) {
> +			rcu_assign_pointer(port_priv->lag, other_lag);
> +			return;
> +		}
> +	}
> +
> +	/* This is the first interface to be added under a bond device. Find an
> +	 * unused LAG group. No need to check for NULL since there are the same
> +	 * amount of DPSW ports as LAG groups, meaning that each port can have
> +	 * its own LAG group.
> +	 */
> +	lag = dpaa2_switch_lag_get_unused(ethsw);
> +	lag->in_use = true;
> +	lag->bond_dev = bond_dev;
> +	lag->primary = port_priv;
> +	rcu_assign_pointer(port_priv->lag, lag);
> +}
> +
> +static bool dpaa2_switch_port_in_lag(struct ethsw_port_priv *port_priv,
> +				     struct net_device *bond_dev)
> +{
> +	struct dpaa2_switch_lag *lag;
> +
> +	if (!port_priv)
> +		return false;
> +
> +	lag = rtnl_dereference(port_priv->lag);
> +	return lag && lag->bond_dev == bond_dev;
> +}
> +
> +static int dpaa2_switch_set_lag_cfg(struct net_device *bond_dev, u8 lag_id,
> +				    struct ethsw_core *ethsw)
> +{
> +	struct dpaa2_switch_lag *lag = &ethsw->lags[lag_id - 1];
> +	struct ethsw_port_priv *primary, *new_primary = NULL;
> +	struct ethsw_port_priv *port_priv = NULL;
> +	struct dpsw_lag_cfg cfg = {0};
> +	u8 num_ifs = 0;
> +	int err, i;
> +
> +	cfg.group_id = lag_id;
> +
> +	/* Determine the primary port. The caller clears ->lag on the port that
> +	 * is leaving, so a NULL ->lag on the current primary means it is the
> +	 * one leaving: elect the first remaining member as the new primary.
> +	 * Otherwise keep the current primary.
> +	 */
> +	if (rtnl_dereference(lag->primary->lag)) {
> +		primary = lag->primary;
> +	} else {
> +		primary = NULL;
> +		for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
> +			if (dpaa2_switch_port_in_lag(ethsw->ports[i], bond_dev)) {
> +				new_primary = ethsw->ports[i];
> +				primary = new_primary;
> +				break;
> +			}
> +		}
> +	}
> +
> +	/* Build the interface list, always placing the primary first */
> +	if (primary)
> +		cfg.if_id[num_ifs++] = primary->idx;
> +
> +	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
> +		port_priv = ethsw->ports[i];
> +		if (port_priv == primary)
> +			continue;
> +		if (!dpaa2_switch_port_in_lag(port_priv, bond_dev))
> +			continue;
> +
> +		cfg.if_id[num_ifs++] = port_priv->idx;
> +	}
> +	cfg.num_ifs = num_ifs;
> +
> +	/* No more interfaces under this LAG group, mark it as not in use. Wait
> +	 * for a grace period so that any readers of the lag structure finished.
> +	 */
> +	if (!num_ifs) {
> +		synchronize_net();
> +
> +		lag->bond_dev = NULL;
> +		lag->primary = NULL;
> +		lag->in_use = false;
> +	}
> +
> +	err = dpsw_lag_set(ethsw->mc_io, 0, ethsw->dpsw_handle, &cfg);
> +	if (err)
> +		return err;
> +
> +	if (new_primary) {
> +		synchronize_net();
> +		lag->primary = new_primary;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dpaa2_switch_port_bond_join(struct net_device *netdev,
> +				       struct net_device *bond_dev,
> +				       struct netdev_lag_upper_info *info,
> +				       struct netlink_ext_ack *extack)
> +{
> +	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
> +	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +	struct net_device *bridge_dev;
> +	struct dpaa2_switch_lag *lag;
> +	int err = 0;
> +	u8 lag_id;
> +
> +	/* Setup the port_priv->lag pointer for this switch port */
> +	dpaa2_switch_port_set_lag_group(port_priv, bond_dev);
> +
> +	/* Create the LAG configuration and apply it in MC */
> +	lag = rtnl_dereference(port_priv->lag);
> +	lag_id = lag->id;
> +	err = dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
> +	if (err)
> +		goto err_lag_cfg;
> +
> +	/* If the bond device is a switch port, join the bridge as well */
> +	bridge_dev = netdev_master_upper_dev_get(bond_dev);
> +	if (!bridge_dev || !netif_is_bridge_master(bridge_dev))
> +		return 0;
> +
> +	err = dpaa2_switch_port_bridge_join(netdev, bridge_dev, extack);
> +	if (err)
> +		goto err_lag_cfg;
> +
> +	return err;
> +
> +err_lag_cfg:
> +	rcu_assign_pointer(port_priv->lag, NULL);
> +	dpaa2_switch_set_lag_cfg(bond_dev, lag_id, ethsw);
> +
> +	return err;
> +}
> +
> +static int dpaa2_switch_port_bond_leave(struct net_device *netdev,
> +					struct net_device *bond_dev)
> +{
> +	struct net_device *bridge_dev = netdev_master_upper_dev_get(bond_dev);
> +	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
> +	struct dpaa2_switch_lag *lag = rtnl_dereference(port_priv->lag);
> +	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +	struct net_device *brpdev;
> +	bool learn_ena;
> +	int err;
> +
> +	if (!lag)
> +		return 0;
> +
> +	/* Recreate the LAG configuration for the LAG group that we left. */
> +	rcu_assign_pointer(port_priv->lag, NULL);
> +	dpaa2_switch_set_lag_cfg(bond_dev, lag->id, ethsw);
> +
> +	if (bridge_dev && netif_is_bridge_master(bridge_dev)) {
> +		/* Make sure that the new primary inherits the learning state */
> +		if (lag->primary) {
> +			brpdev = dpaa2_switch_port_to_bridge_port(lag->primary);
> +			learn_ena = br_port_flag_is_set(brpdev, BR_LEARNING);
> +			err = dpaa2_switch_port_set_learning(lag->primary,
> +							     learn_ena);
> +			if (err)
> +				return err;
> +			lag->primary->learn_ena = learn_ena;
> +		}
> +
> +		/* In case the bond is a bridge port, leave the upper bridge as
> +		 * well.
> +		 */
> +		return dpaa2_switch_port_bridge_leave(netdev);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2250,8 +2572,8 @@ static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
>  					    struct netdev_notifier_changeupper_info *info)
>  {
>  	struct ethsw_port_priv *port_priv;
> +	struct net_device *upper_dev, *br;
>  	struct netlink_ext_ack *extack;
> -	struct net_device *upper_dev;
>  	int err;
>  
>  	if (!dpaa2_switch_port_dev_check(netdev))
> @@ -2268,6 +2590,24 @@ static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
>  
>  		if (!info->linking)
>  			dpaa2_switch_port_pre_bridge_leave(netdev);
> +	} else if (netif_is_lag_master(upper_dev)) {
> +		if (!info->linking) {
> +			if (netif_is_bridge_port(upper_dev))
> +				dpaa2_switch_port_pre_bridge_leave(netdev);
> +			return 0;
> +		}
> +

sashiko-nipa notes:


	When a single DPAA2 port leaves a bond that itself is a bridge port,
	dpaa2_switch_port_pre_bridge_leave(netdev) is called unconditionally,
	regardless of whether other DPAA2 ports still remain in the same bond.

	Inside dpaa2_switch_port_pre_bridge_leave(), the bridge port being
	unoffloaded is computed by dpaa2_switch_port_to_bridge_port(), which
	now returns the bond:

		lag = rtnl_dereference(port_priv->lag);
		if (lag)
			return lag->bond_dev;
		return port_priv->netdev;

	So switchdev_bridge_port_unoffload(bond_dev, NULL, NULL, NULL) is
	issued for every leaving member. Since the matching join path also
	calls switchdev_bridge_port_offload(bond_dev, netdev, NULL, ...) per
	member with the same brport_dev and a NULL ctx, the bridge layer has
	no per-port handle either.

	When the first of several bonded DPAA2 ports leaves, this dispatches
	SWITCHDEV_BRPORT_UNOFFLOADED for the bond while the remaining members
	still rely on the bond being offloaded.

	Should the unoffload only happen when the last DPAA2 port leaves the
	bond, similar to how lan966x tracks per-port bridge offload state?

No, switchdev_bridge_port_offload() and
switchdev_bridge_port_unoffload() can be called multiple times for the
same bridge port, see nbp_switchdev_add():

	/* Tolerate drivers that call switchdev_bridge_port_offload()
	 * more than once for the same bridge port, such as when the
	 * bridge port is an offloaded bonding/team interface.
	 */ 
	p->offload_count++;

The ctx parameter being NULL in this patch does not have any effect on
the offload_count shown above. A proper ctx parameter is provided in the
next patch when we add support for FDBs on bond devices.

Ioana

