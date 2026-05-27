Return-Path: <netdev+bounces-292131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKtnBE+aFmq1ngcAu9opvQ
	(envelope-from <netdev+bounces-292131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:16:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA75E050D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8DFF300E5D8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810233BCD33;
	Wed, 27 May 2026 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lQI5ksZy"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0427E07E;
	Wed, 27 May 2026 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866177; cv=fail; b=dNRwc1efUZL2dD7/nChJnK8g1vAXGWZCBNMVQyhC2WEbnD2cAg64IdNgQIbusq/OvW2HdIBjKcIvp3e8oU4bAv6cLhIyEGrH0FxoUOG1xJ59nlHDEtvWi7NJEWQaEWppy60Wkw/vqEi1Ns838UE4RV16TNR/rpneBCoD1+gOi+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866177; c=relaxed/simple;
	bh=xkhVnyvQpXgqqDuVIrWllHgIair+nLHPqH8m9zNucMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tZ7nwEbXnL3goqlSqAYCqygv8pAxfEdy0c2KfB4QEaj6NWzpfRGIh54TwWtIz9x9VrSpn1RtfrQPH+h+dI/NNRQ57LrBb61ElqBZ0tlnh47BLsy/JHhLF9g8EFf5bjmYET7/XjMpD7LwwuPsaVtCs8V4zOXT8Rj9x6Fdal92kGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lQI5ksZy; arc=fail smtp.client-ip=40.93.194.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4lmhium6spuZbdeV0VoquoWA3ORauXymNtAhFA0hlnUic01J5VWWaD9OENcVXtggm9PGNV3CC9OtMt8R6ESO6fRZUI+INZ1gGP73uxKdzVy0QapeUPWg6iZkW/2grra7s17GYOMFyycsYlUX1BBRzZJHXpqt1KnhvOgtnehaddh/wS14L/QdWQiu3GwaGaUlHyS7HYIGj3qqYWeIHyhvE1DKjp24gvi7FrB3uj0g/sNZdE7YlC8HFNhItczRHsUZbNrMAZBKZxTV0HhBWn+yrOrEwJFMzgMU2cK29tQ2HYv376qB7GznJkAeLIKWYbxKC7EFeVTlHYDGLUesANMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkBysHVwVbL7PKwvqXHIVtAEVK17g+/lOFHH6CfKTVE=;
 b=KAKz7IclYRYcpBrZ+lzX4/A1xsmb4JSmjo2lzDHW8SYpatQkXauU/I3VaOt4swuZbC7B1ysmrTDpObg80NObZk029VjWtV7geA+h1rC0w43LxkVipa2ctZbZ6sWBVxDLCoSNjEtwRZ0dl7tR8rtWUQnsqE0YhlVfpEh4ZV3i4UBU9Igq7yBbDareLJ+qsQCZ9+/H+ok2ws1XLMzfs3N7bJ2JzMVnp6JcuV6w/sNNWq2yI2XZulTLqfGvdKOaUqfxaSbVZJZWT2WD1InkspY87dquZzUT11XQRmBPYEE3mEsoWp6QRFgjMnnohkfk/4TTFHVcvH/3Ox3cIfJOciWEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkBysHVwVbL7PKwvqXHIVtAEVK17g+/lOFHH6CfKTVE=;
 b=lQI5ksZyf59GJr0hF1wkrqCOI79f1veUyqCK6O4Wvp3iV7kTxGOFcYLcM5kyGm2fUNmC2aE9ArrOdv21obgObvb0NiHKMI5U7J5IockVuB8052wWd2a3TD1luGXXU+pm+JPEqyuqafzD5mvNml3O0J4OLT9S+aVouv4+KLjiLbYPhVjAGx18s/otKGXHoFPE/fbixir0MEoy9iaxuB97fw8Q1IAtICGmmzgZjFlBTiZVyWNxJdKCkT3O01QlvNmQG1I/DmdHQjUK5C/LZmjF34sFT/MUjQIJEwg3kN/tpdeMthC8xFjAjgu4GUxC6aQYbmP1NWDb7505ZrwOjsZYsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DSSPR12MB999212.namprd12.prod.outlook.com (2603:10b6:8:376::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 27 May
 2026 07:16:13 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 07:16:12 +0000
Date: Wed, 27 May 2026 10:15:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: mcast: annotate data-races around
 mca_users
Message-ID: <20260527071559.GA432853@shredder>
References: <20260524022456.20689-1-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524022456.20689-1-sigefriedhyy@gmail.com>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DSSPR12MB999212:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d24c76-0ee6-4261-edfb-08debbbfd577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	HIvuqN1CQf8wH4KCN15uttBA8IYxOfhPLHpXt4SGtlRGd5me7docyPe0f3H0JFAa4/qO49GNQHXsDmLqOhaXFbZ0AC0YxfOpR5Rnf6OtNicTdqFQ3e6xi+5zmI3cANYgr6fktAi/u09welpYOyDnbd436FJ8lTufpOo1b9aNsvDCn7ua8tHkeKZZRquQWusojIJCbMz9yJ8nznx93DDMUSz17Pl0ZBMnqyXZcqCw12WP9f6UuuoTvxlHkhZ7TAC+vjjUGtESQYAemISZwtrkPPR3VvZ7KBWb6cnRFRxCqlY5G5tVLFjRyLqvZawLXANMnr6Eb5SDUlT3Znfm9eiA5oNoNTpTtwrvtr2H4ZCkiey9RTeyCkvSdRPUilTOl7gR4U31CfyLSFtJI6XCGEhVs078EzpR/6fmedgr8Dk/WEWn3HJ4vi0rWAwdcaBLYxPFEKxajOTBIbMnQUkEELDmPg2B73XG95Det2DrJyJizDMZ/JOBqhn5FT/mf6gjT8d0q9MF9QajvhsjMO1Larvz0XCRGpfcTG4g/GnLxA2snteqHIjPpygHyRFCWep3i1HqSGFON4O8vlXIyW3uM9ijO8dAGcSUYw5+GgFRN8qZMs3Zwdumx7YiHL7eXalmtTP3CuQhL6UFr+vTHKv+2g6ohG8A4FT0e5bdjlrX4unPf00/x2KuMUI1yHoEbxSXWqjj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dc0t5qpj1fjT5kNQYXaAhiCeb1RGiQUftVwYVxFaxBP7dGHr6P7Hf69S1x8k?=
 =?us-ascii?Q?pwvWQM5sVpBlStDk0Wxarf62CD8DgFkl8Tx9pptvTAxC0J67QTD2q/qSaz/B?=
 =?us-ascii?Q?p6rmcMnoWyrRejfOQc1XbcprZ/xqdePvQLqcFDs4el0C7CHETQaoRoU9B1lD?=
 =?us-ascii?Q?5uFyCGFIP0eO/IzOtV+ELa+pd95X0+r7loVcA1BeUlahDyfAjL0wyCSw17JU?=
 =?us-ascii?Q?lGCx8DflEUyf7jLxGdQt7zDCeWWN3zHwds5pO6j7PhZBni6fmoqGcUYUwYCx?=
 =?us-ascii?Q?pCabM0lvkP9x+5oR2E3jVGoG9FmdomFvOEEYU/rGpdSN8YHCF6oIIrjsqXH9?=
 =?us-ascii?Q?Bz2ee69POfL6hIVRQiPTTlCdPLkIhqqfEFk9csrGoYSkORHYcyBaveN9AR/G?=
 =?us-ascii?Q?rWoLjz370U8dRgNNM0cLmbhdmsSHQyTBCwP0STTBjgkj617QDCvDTf05mfg5?=
 =?us-ascii?Q?hQj12fD3HB4OpscKpWApSQxi1q0YC7rRd37qJ0eXRpPi89SjBULJmqjgPZM5?=
 =?us-ascii?Q?0JBjM9UjtH7to1TfM3NStaPz1x48Nru7aLvPGcaz5aGARbKBljTCYQ5oS0WF?=
 =?us-ascii?Q?OvqlwbJat5xpKAU1/VLTlyG2Be2uH3l9fpsZmcCd/NYrcvnJp3UUAwvUb7zo?=
 =?us-ascii?Q?oXyimR6NA8SXfGgC6n/1Ft+jv5UjEDe23eqdbkH3Th3geQ9CZ3SNWb+BwQTk?=
 =?us-ascii?Q?unrjBu2pdoFdTY5UgqtFazWxL1+znOqLvx21HWt6LgKwHEaWyNxXgeOdWEtG?=
 =?us-ascii?Q?w/Trwjk/320o9SVtZ9Rc4MSPk6NPuByUFkXNZ59kr+sf1Wd87WP71ce+We/+?=
 =?us-ascii?Q?KRpAVvDilEONs64Tnxai2ZquiSt2C9DzSiUUutEmDf6GGIY4AJczdspUFwSb?=
 =?us-ascii?Q?YIGpUEv/jOqri/K1wwC49Q5PNNnIsVLzqmmNzbrzhX3PluNz9bBUl8+fd/oz?=
 =?us-ascii?Q?ZlIjNkirQC9PSjSl8GIVFNF8K41GPfjEJxKVBhMEZohhgyL8HPMAd/1/hxx8?=
 =?us-ascii?Q?+S+juAOb9pe/6Ha/XVUryQV+Ip/rN0aMOo+8dFyWyfCmDN9D1u09Om68Mkyz?=
 =?us-ascii?Q?Qs2Hg5M/Npk6h/G2P/6aWs0TXCAzLagTUYOhGkwrjikP9yVZ7QHDzaL1rLmV?=
 =?us-ascii?Q?DXye3G63/DCDBUa+iqWBmRB40qSTWLk5NVU7awd66xD/OIJYnoQtS5Sf3PB7?=
 =?us-ascii?Q?SmSNHeBFt5ZmRjVsF9Cqc0A3Am6h90YH1sBV+epmqvfqk5mf8sqxKWpPsPdP?=
 =?us-ascii?Q?5DTSjEZ3EM//Kkk2AkMjYbjSAwgiPxcBT8XTymMKdyBjIMLl7q7zIA6FsSVH?=
 =?us-ascii?Q?Ri9HIJnx058R2tVjiuKvqLrY85zpQ3VOpiuTDjJypmetS/pC7GIIKIwQ5Zoa?=
 =?us-ascii?Q?DADKGo22KqKgMHFuqD4nlb1DLrB/kVrCJyFWr3tRg65hqTjP1kDx4G25q5R+?=
 =?us-ascii?Q?VQMCvYS2puDCm6bzO8iYxXvTffSLtMFVA5DomkvicJu3qWSuNtJ/8pvKcHmX?=
 =?us-ascii?Q?bIiatbDj00td9TNPHiJE298gkTCyh5JLXjCqyytvEJpZTuvO8GZeLnTfduwq?=
 =?us-ascii?Q?LFT5BklUmaNitcuppyJpwmfQCRYZJPZiKybxB0crBJHVk9HBE3df5EgkI8SL?=
 =?us-ascii?Q?KZLEY1SdYURNBPqtnjPDc6iT7A8f7cFxq3Nqy1JcL+yUATQEXu7lHfbDKIHe?=
 =?us-ascii?Q?mWCuUP04jQ9DvYvwLfx55aoq1XBfmqxrmBke0xBLTFgNFuW/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d24c76-0ee6-4261-edfb-08debbbfd577
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 07:16:12.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQ1XH7AwhG5Wi1cfioDTnj4GNsH1puT8l7y6TFgHxmsmR6bYlo9YmKE46fcu4cxDntN6NIcxr3T2d9Sy8Je6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999212
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292131-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 7DAA75E050D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 11:24:56AM +0900, Yuyang Huang wrote:
> /proc/net/igmp6 walks IPv6 multicast memberships under RCU and prints
> mca_users without holding idev->mc_lock, while multicast join and leave
> paths update the field while holding idev->mc_lock. Annotate this
> intentional lockless snapshot with READ_ONCE() and the matching writers
> with WRITE_ONCE().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

