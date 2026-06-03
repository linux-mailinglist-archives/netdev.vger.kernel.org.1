Return-Path: <netdev+bounces-294664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WWUjAQTeH2q/rQAAu9opvQ
	(envelope-from <netdev+bounces-294664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:55:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7456356B6
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:55:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=NS7Jakgv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294664-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294664-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B32730C1CF1
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D4E3FE663;
	Wed,  3 Jun 2026 07:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DCA3D523E
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:47:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472852; cv=fail; b=Hwst16rTsfHZqfH1D6QUNYrjuB5aEIJrXa2Pw+pTJVlbvPVlbLiy/V9biaG9ncWEn77rf26IxiKikmuEmk1lIsAuEDlSmarU+HApQ6GmOWeTBl4MMJpHpRRnCfGk8w9OOmKrBAGcWvgUBVMmWLYJVs/O4L9kI3phXznC4pdn2jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472852; c=relaxed/simple;
	bh=TkiwLqptn0ka53s9QDl92xpfCEpZsxmC4+5FfFO8W7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K58P9wm4hdLCeTTk0Q9HH7Hp1PQ+xTLTL/GuWxjUnTvwjZI/LXHVCobENXNSif6DYCFDOsvmjdmLeXREUkYbPRqu1CXOSMO5O/vqdxIpe/V+WU1q1WVRU+R6pjsSdx16so7BTlB0LdTFLr+eVRNCf8HFPYboxxyXgF0rjHq6LVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NS7Jakgv; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mj8w5ycILX/Npotg/DOTMmO4YYI4CKbBFCGyjjR6IY9TRo3/6VeDf/gPE3wejkadardtwkQWflPqvqJrGtothekUQii5P2rv3R6MRHIVI3xhKWfKsFbewwYNZ9+8NsgBZ1on09idqK1MJQvOwWL+i2+681UC8H0X9QciS2myDT1l4tT8nu9QL0uxARX+TFOAxDfK2Ob6eFhkJkR2OHq1499rLecEIP8RGrhtTjgMW1pTtDRtjCp6Lzrspbw6OgvJXx5Gkr0k67Ctta0lbgddu8HUHqD3lUZI1Lpa1qWcB0oWGAzE0flBsUnD6ERcJpugH+RoWH08Jvsn0oWxYp7/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i9j3923jYIEgs4O/ngxAeoGG8I0uaZoGeZQ3ev5t7U=;
 b=mhDqhCS5/09GlNttoH7bqGB9pAYI2k+IZ/+wC/9hp/xiA08rTeyHaiJkY6AYwOuyfhpJ+TZUCN91lhTxrDU3BqwjfZkY9aCzM6emvvGY+mg8vATKllSIZ7XG4hOzjVL6dH2Oc6vVU/gS6gaf9AUmc9i91CO8WKiZ+WYRRTqp6tenWceCN8jiyVnd3z9jtKufnaZK43IANLZ1DeCj3bPysnL5tBNpJMRWs4eo3Erohh2Ry6xWogxAIOehAvcA7g5RCghxSwTH1lri1WWSaNVpdUjpOYgvLqAeYqmAlTIcpaac6567NLQ/QHMqUhu8d4CPljwVelzSmtS7ykwnac4LEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i9j3923jYIEgs4O/ngxAeoGG8I0uaZoGeZQ3ev5t7U=;
 b=NS7Jakgv9N9x4AnvPZIOuHBAWPJYD/pAuT6uSyvuD4OBlqh5QExR7gYcrKUheYlVUf3Xw2TNOSHrFsdyexMdjrBTTgGr+iyRINmzJ1DLgYKz5toYJI3+NLNKIE29rd6XSSkF/lSc7LzxXZM8Vm2qVgz+o5Z7CBNouM+MKfsKF31EYE5AmKI5fpnpuK53jamDIvjXWN7lVULagGCIfwzgE8IWBRzLM/ZJU9CmurIqfbUoXvQiQ+3IrRYKBH3nuvahh4/9AHvPp1Rs+gcUm+LQ6c92KyorfQXb7apWBaxPui+HouUTnNpLagaKCm6HGo7BCKBGk9LyjP2JYdmC1VCYLQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:47:26 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:47:26 +0000
Date: Wed, 3 Jun 2026 10:47:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Stefano Brivio <sbrivio@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	Chris Adams <linux@cmadams.net>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Andrew Lunn <andrew@lunn.ch>, ihuguet@redhat.com,
	regressions@lists.linux.dev
Subject: Re: IPv6 address insertion order (was Re: [PATCH net v2] Revert
 "ipv6: preserve insertion order for same-scope addresses")
Message-ID: <20260603074717.GA569921@shredder>
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <ah57wxGjL7JBORR1@zatzit>
 <20260602132118.GA508395@shredder>
 <ah-SvHdPRrYXX6lx@zatzit>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah-SvHdPRrYXX6lx@zatzit>
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f83141-e507-4651-43ad-08dec1445b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|4143699003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gBtZNuwn+orXNqZ2Kw0Nkl2rQmK8J9337gG680xzXXhP/wsXm7ti89oOr9heMTK7JhvQJytBDdBHXxk4VatnahITLdKTlhhjpuwull3K90GsGT7FBQEo5jS+uN1aQ62P366TIz0LUvkiyUe1NTYlVAkvICqSTy4mLN/FFjVgxEosE+DKX2ltD9hHaTzXypafVRQlQY9VGt31YFZD1oYMQrykIXsYzqWaSPjTsGX+BXvpT7kPYk+WtgaiFQKHZld8crv2IMX1wX2eMeH9fPlfvwNjDLMmk3CydJKPjUvX3fy+AH7K41oTDZslyRIHwm542piCtOkvelPSSiEQBgJydm0t+7jn77jkcsDpYbrVWnmVEyUA6YMcN7CNPWJa27agZ1MHxnxdz1t3kQLPLBSnOl280AlFBXlGersd6IBsYotAXoqMC9m/L5037XqoLf5tb+oQkpxrJujH+1ifrOJvZpfNobucqOjNTiJy0omkC5IvRqUu6FxogtSPgZ92BzuKLb1aiZubl5SJA/wJeGPPYojci/hbc8Sl6z1jEGgwdzus01Ib9EpmbcJjitNEhZQLXYMNjbTx2xHqURMdqQjl6m8ipPr+5OCASsEdEYz2wl2Klcbvr3TrTAJOAs2tfoITeodAHl5xWN3C2YaMSMs17jQkduZw/hdGdYmAGGg5Mwb3b87rIxNWl6M9XOeWyJVvKkflFsmUZdapUV1ZkKR9wQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(4143699003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9LTJlOXZUZCX0LB3HrBfN3P+CE164isJZvoh4WGfgZbh0YJ62SDJDbXXPpaw?=
 =?us-ascii?Q?Bnoql2ZsCSOnJ5H7TKqtj1npjtc6cBUzdG0SbeywNFLEn7819AqaA4OUZYiT?=
 =?us-ascii?Q?PYicZpXSIuTfcvHXPOXFkxomVqxdKxIfJeKVmAeRHDTuZvV1ajrp9PgLdOxw?=
 =?us-ascii?Q?sRfly4fvxVetzKx2zmet9vXNI8Q4EBSGFhFP2f3hb7kiP/Hl72cIzxItHJHS?=
 =?us-ascii?Q?lmMnx/PvgFfEjHAKYpkBg2Oqvajq46I4J+tDWp4k7SInWTMBqICJ2gmhzP6z?=
 =?us-ascii?Q?8JNQJSGvZX+ueXN3tUSjgWhXglbjd7dibPuV0/rLnEH9jBRuy9B9dF4CBit1?=
 =?us-ascii?Q?YZY0nYm3Q9gLlc5wi7+udn29SN5zT53I5PGLyjRhntUdir9P6GxG4w7NtpxC?=
 =?us-ascii?Q?Ybkfdqq+uGDAjP2OPsDCIQwEouqqZqgVh9qS1BUNcPwJPcofoXXWPQlwb4Kp?=
 =?us-ascii?Q?Sr0MMofq7+pWTX7v1YHoXIq42podoJlDNrzk4A+Q6MJ3DKKHbTL2HQHpNahB?=
 =?us-ascii?Q?HbuwXAcPJFlSJVM9CvoOfVjdQFBZu280kNEIWgpFTsxYjbca3WmJ2dEFaSTw?=
 =?us-ascii?Q?V1Q4gEaUZKvXd11TOXdiY76j5q9UyMulnEc0/Gcze2cqOnM+2URaMlcso9VE?=
 =?us-ascii?Q?qnMuiDzA6RFxU+oTWRampKPehuujUHz+T179vfny5BhR/wO0GFh7CpkmPoBJ?=
 =?us-ascii?Q?/7SraQPrsNRJA7boeIcgY5lYj8JVrEBrsNT1tKZmW96ToKbhLyACFan0XpC2?=
 =?us-ascii?Q?TBs4OTFjKQmHBkeNt/aOtaY0murA8jk7Mng9PunlMjToRla2duDfdQz6Mde5?=
 =?us-ascii?Q?94uCtcxja/zkWo3wJ7P7P08zjvLmFZJqejAwZlVf7QGWBeHe+LJ+xfA+Y1ws?=
 =?us-ascii?Q?LXChtoYlTupGHhzgWX7/rNi6j6PzvXwWS/TyH8HgYsr+rFrKFOR/NZNDm2wP?=
 =?us-ascii?Q?YPWczeCeWOmlxQK5+z1zUYW+RmL/k7rsin+0CeGoPgm/Xs0tVldEU5Hh/QBX?=
 =?us-ascii?Q?MHiQUlzZCcOGwL4uMvbhLEElfs3GqVwx11txbwdhkFxedOLJMEpWWbr4349m?=
 =?us-ascii?Q?rogmzndHhx0oU+iGZ86vCr0iBmm+fobpYbUdZ9jiyPj0epJLdXFDMyYK8Cyo?=
 =?us-ascii?Q?AkDCOYRQTmmjbAIJ6NSWs5L0ImvEpfp6SLb91GaGqP7e2dWLZfjrZufPo70x?=
 =?us-ascii?Q?bhMY9Zwbefkwa1kx6vZtUDd7FVw5uml1rPYDqQHr2DQjrlTmjGUXizWy0akN?=
 =?us-ascii?Q?RuXIicyYn46/8h+hfeo3b77w2IEQXmV0rcKFA8AcjxqSrt6FQeKN1mMZZqp+?=
 =?us-ascii?Q?pUQZnK1Zr9joB5zBCFmwLL3R1xxxnuNpju/+oUO8HNsNjl8cZGwKBxtE9tdQ?=
 =?us-ascii?Q?S+n5Cv2o41KH3P2ivkKlkf6oUFWHw7dP1pmqnbEanNr8dgPUsxW/BvfZAwIn?=
 =?us-ascii?Q?P5zNyFzcg/I5LbP7K23NPF1nYwxTAerdPp3f2T6IIZe26snaKP6Tk1Ld2yiW?=
 =?us-ascii?Q?OVoOeZi5WmeKxocLFlpWVRuWcIjzRd/XWIK8yPFMFY54b8b9b79SZ7ptWZMb?=
 =?us-ascii?Q?oSIFR7WLPsjmkB1PTKcPYwel+a6UtSEMdvKBfnVrXOzt1boSPJgQs0k0r43j?=
 =?us-ascii?Q?fxr6Wvje+x2J29mUerNOA2aOn8CAxainAqj21OT9EZaiu94bBzCf14zz1QMS?=
 =?us-ascii?Q?TrbsNwOg8kZ2Wd5eNjIcALlmedEsLYsm4TPtip+f8cuoef4Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f83141-e507-4651-43ad-08dec1445b22
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:47:26.5728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Rguq5tjjZGYm0yOhilXvmcw7t4t4uOXnH5KQHeLzK819mZe29blBb5G8kYrlaPbuiZDeZ+mMZi4T1zQ97mpuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294664-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david@gibson.dropbear.id.au,m:sbrivio@redhat.com,m:fmancera@suse.de,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:linux@cmadams.net,m:bgalvani@redhat.com,m:regressions@leemhuis.info,m:andrew@lunn.ch,m:ihuguet@redhat.com,m:regressions@lists.linux.dev,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,suse.de,vger.kernel.org,gmail.com,kernel.org,google.com,davemloft.net,cmadams.net,leemhuis.info,lunn.ch,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:from_mime,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E7456356B6

On Wed, Jun 03, 2026 at 12:34:36PM +1000, David Gibson wrote:
> On Tue, Jun 02, 2026 at 04:21:18PM +0300, Ido Schimmel wrote:
> > On Tue, Jun 02, 2026 at 04:44:19PM +1000, David Gibson wrote:
> > > I get the impression there's a rough consensus that the best we can do
> > > now is revert this change (already done), and make a new patch which
> > > changes the insertion order to the "correct" one conditional on a new
> > > flag.
> > > 
> > > Stefano has enough other fires to fight, so I'm taking a look at
> > > implementing that.  Some initial thoughts, that I'm soliciting
> > > feedback on:
> > > 
> > > 1) I'm assuming the idea here is to add the new flag to nlmsg_flags in
> > >    nlmsghdr
> > > 
> > > ifa_flags in ifaddrmsg would be the other candidate, but it looks like
> > > it's encoding properties of the address itself, not about the action
> > > of inserting it.  Plus all its bits are allocated, anyway.
> > > 
> > > 2) Could we re-use NLM_F_APPEND?
> > > 
> > > The short description of this existing flag in linux/uapi/netlink.h is
> > > "Add to end of list" which sounds like the right thing.  Looking
> > > closer, however, it seems like what is' used for so far is things
> > > where the entity added with the NEW<whatever> operation is itself a
> > > list, and NLM_F_APPEND causes it to be added to rather than replaced.
> > > It's not used for addresses at present, AFAICT the list of addresses
> > > is a semantic level above the address entity itself.
> > > 
> > > So maybe re-using it for the thing I tentatively called
> > > NLM_F_INSERT_LAST would be confusing?
> > > 
> > > On the other hand, it's not used for addresses at the moment, so
> > > AFAICT there's nothing actually preventing us reusing it for this
> > > purpose. That would save a bit - we only have 2 general and 4 NEW
> > > specific bits left, by the looks of it.
> > 
> > This is not really viable. Even if the kernel is not using NLM_F_APPEND
> > for RTM_NEWADDR, but not rejecting its presence either, then we can
> > create a change in behavior for a user space that is currently setting
> > it (intentionally or not).
> >
> > Example:
> > 
> > https://lore.kernel.org/netdev/27c249d80c346a258cfbf32f1d131ad4fe64e77c.camel@debian.org/
> 
> Hmm.  So, in this example case we have a known, widely deployed
> userspace that was broken by the change.  Similarly with the
> original now-reverted "fix" for the ordering, we have a known, widely
> deployed userspace that was broken.

It was also reported over three years after the kernel change went in.
Point is that we have no way of knowing how user space is using these
flags. Suddenly giving them meaning when we simply ignored them before
is risky.

> That's a different case from a hypothetical userspace that incorrectly
> used NLM_F_APPEND on RTM_NEWADDR.  Moreover, to be broken it would
> need to incorrectly use NLM_F_APPEND on RTM_NEWADDR *and also* rely on
> the counterintuitive and inconsistent insertion order for IPv6
> addresses.  Absent a concrete example of something meeting both those
> conditions, I'm inclined to breaking that hypothetical case when the
> payoff is an easier route to get known cases working with the
> preferred insertion semantics.
> 
> Fwiw, I did look at the most likely candidates: iproute2,
> network-manager and libvirt, and I see no signs that they're misusing
> NLM_F_APPEND in this way.

See above. I don't like this approach. IMO, it's not worth making it
slightly a bit easier for some user space programs to adopt when the
risk is breaking other programs and repeating this ordeal.

