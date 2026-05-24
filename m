Return-Path: <netdev+bounces-291174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Pg6JnPzEmpq5gYAu9opvQ
	(envelope-from <netdev+bounces-291174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:47:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 299345C2681
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53F0F3002899
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FBF3955C0;
	Sun, 24 May 2026 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I8yC/TbV"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A32D8DBB
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779626865; cv=fail; b=qKdBKdJ+enuL70544CLNJOw46TMbc7dgg9txlIxDbPqYBUSy+YwLXfGwK0h65jxxkTBf413Kn4q7EByLhyIfcbifO9kXM9CoB0avXKXVmkNCHwHXifF7MWeiFmRgYvAwPNOj4grZ0olvWBxjzO5vFlN+DbgWrEucHO35UVrCnxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779626865; c=relaxed/simple;
	bh=4FMJ1vI5ZbcgKnjvgxRZJ/CexGZlzi8rEEdqZLOzvOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dxUv1Vn4tGGYtyxbcwEoEEAJTRusp0bnaxqa6kTiRmRjizRj3p8/SnXOXFnao2QC+jeJriIdHItujHBd5a83bghULRuAHeUBQYAao2/KUM2byLnYUw6LFt99kMb4oRHwHDxsqdOqw+kXua4fBgSsN7YeXYgpMIpKqElgMlCDmr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I8yC/TbV; arc=fail smtp.client-ip=52.101.61.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHgb3o2nKMUkdDV+N+vvk6pf56EIftcbZx7wOllCfExUybX0P3Wbgp8sKWjCHxkdQAbfC2/HJEwHgRnViwiyjsKmU1kvQ6hkFrU2vUOy6Q+/IkJ5tMXyBwiHrZRps4CMJORKyfBNTTnvlDWghTWFKXC/11gdRvQe9YEIywuRZur9MMeZXjHjYJgn2IgtyB/LVUqCH3bFxu7B31eoY2ciYokiDPlXqpkuV5ihBQzpcj/xjQvV0lN0OzKYXCPwtLq5yga2XEMt5sFVXR4xlbGFydo1p5tF2UrjxZPrA0GVuxX55yQVCJhZZDBDVJsBQqW47sTQaJyKnnSTgbAUh2z3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8zzkuVekfeWXyhFEEcN9NGTpakd8ZEJvB5qEk/2GlQ=;
 b=Vh378G6FRa/F+yUUhEEePRYoP3KvBDS/yBMKtR2cU+S0DsHRD8HnKxH1S8vJmHEylPeaIIobn6vUtwat9MC93bGvN+k1OcjlujnVuSRpcYyuIy44kGQv4RH+zy1+vCimp8HQ6MtM+hVjYQMP8Xvxmy8R1DBfq0Fk+yf1bjfkEilXdzJhfa9WOzyRez2PqMaaQ0kkANQ9XUYJ3Q5i4qMe/KcDcMS/84YgMuSIUgu+/S3QNXmlKbYBw6Vs7aYnaN6Ra8FVjijbyhMfNe03yX6MS0OIcG2tmo/5+Ij72/1+5WzbJM088/VZZgxorOBq15Yk7JRJ0tUuSqfLgpnCsagqZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8zzkuVekfeWXyhFEEcN9NGTpakd8ZEJvB5qEk/2GlQ=;
 b=I8yC/TbV8fvHSDGr1gteaeNhy/TzQYqdsQEgVL+N8Ne6xzDaLPcenD77vCvvtp7eYrQso2mpupTm+RH6BZM6Grbd3NsdWllxjL5yegZ4tABiXHRLXk9guiKJVNRuCDalk/nSbG4xQpJ1a5EJRSU/2hA0ikZghWFfB+t1NFumoI1Hu+XJ/hD+WaytCK4DEktCg9mbWEMUxB3s1sDtg47MuepNrUT5K2N6U2Sf/oVy6VT9wGR5SutFB9za+46lonevJnkddyMz4ggp8R7OGKSqO7saWlKWqpbXAfWykHslL23D+PgmLHemEzEe7w3y9vhzpF4Wvn6+hZH54GuCBKjmAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:47:41 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:47:41 +0000
Date: Sun, 24 May 2026 15:47:32 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 04/11] bridge: use BR_ADMIN_COST_BIT
Message-ID: <20260524124732.GD74116@shredder>
References: <20260521131916.3627204-1-edumazet@google.com>
 <20260521131916.3627204-5-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521131916.3627204-5-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c007933-6c8e-4726-2296-08deb992a4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	QwX+mh801dir3FVn9MskeoXQKUG4HI8LR1PFhC6/+eQorJu1Sy8PA/pjrw1VpZKYOiYJ5fhbrqfQ3BU9zpRrzEtM/sVaudlV72gu2APeSxrwrhKo7f1ToFVWGuL0dyh/JuFxtXqmYOk1OGaFT8Az2nr6d4QvneT1SOeC7//+/PhF65853Ibl2xl7S6hWHO9cJ2A6lAEsmqtkVSiuV+3Fu2ouhOevs/96CVeroaRkHYWcicsIaLt2ABbIVbfQ8JhYKdbVwbb0dhdqVZlUgJqhorxuIzAz6kIhsSKQ5Ayl56YlJPyQqLP6rC+nJ/Wmx0BCPudnntVibhj3z5UZ0dahq/rTQjRSVhoA4aGtNwJ6H5ozlJmVF0nCd/NcYEMOME33gntfAFSe0ouXxrH2i3ltzfpejmPxQVEgYAz8NMBptju4Q/YjjFtw9Kew09FbHD8Mwdv3iTx7uxnbdQ8Ye+AUfCIOXMbgHF6fpbekO5fwa6m3/EsMPbkQCxrbJmvXmyBmJPxnvjEVvLSfXGxly9ubgN3g01/t/c/g3A2BSEaZc/pV5ZEJwUMUSrsuxC8ie0lKKPVV7R5wPpbkluIJKPRIZ74Y0LcTPdgiKGfLodujH5nJVa7LbbLGDv+Eu1TrtkL31lc4n0w8/J85tPWlmUB/ej+BBUp5pn23w3Hj9GJK+jTDAX5bmFY9Ga3nZUM/JZAU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S94QDzRzApg5ZgP31S+x87UeEJcMpodXzXF2p2QHMsjAEBft1gib2P0vReY0?=
 =?us-ascii?Q?FKSRPwvcWjuYJVeSoSqvV/s3H1Plf/7aU+RGKXeU3wccPC0qygAXZMcbd7sh?=
 =?us-ascii?Q?rB9K0bJRoXQN+y/9It3QJx+Z6jqSMr6ia1ZpIfiv+oII5TpS88bCQxP88pFf?=
 =?us-ascii?Q?NeiJ7kf+qFKBLnCZDwF9dEdwBBRFZLZp2nK02/yS5OcRFbNtzN/5crPRHfh/?=
 =?us-ascii?Q?prCU/mPEKKEGEWg0Wb7VJBX8Dr9l5bzVfWvbuA3TQyc/2MFTLNFXHfmSmBSJ?=
 =?us-ascii?Q?Udh4Qt3AODdFIk6MOyKe8UuGZfcaFkybglnPt3RS1Hy9jCPvND1RFV6WnXTy?=
 =?us-ascii?Q?TwXO2aXtaBfP/BZzFi8FjczagX0IjMefIy6f0VtIhsicVR+Y/j9bjrMDpn0s?=
 =?us-ascii?Q?zQljhdt1gBPfZcS30OURrDWd2z76SDln/yRSVrLK8SIM9spimB7gYCop2hXN?=
 =?us-ascii?Q?z2nmeuk0aVI9yQCI4YHT9olVPeBJb74PXCJ9LTjwFSO8dfD3Gaw+VdJEj14s?=
 =?us-ascii?Q?J6vVKnlHtvfBPUmGAP19fhE23X0msDICe2vb3Cx/Fi/Dt5HOcGMGpEDmtkTT?=
 =?us-ascii?Q?ez7vnkhixWsySZBa8ThWzJv8A+fn0Szos7F3t/Db5cOkx8BBZkJ0HSFXhWmI?=
 =?us-ascii?Q?j1w0eemWUmraGbYhITbtsHQkIMcGzOJuvVOTrvxvH3rg5FtqgjZ97EpSemlz?=
 =?us-ascii?Q?ddbAW5yyfaLe4v0RCLFvmpP+8C0BTR4ixFyLh+e0fmLK41IR/M1g3KS6dY/p?=
 =?us-ascii?Q?3/bVaRuWT9jHcBlJzYxfmjVrMhDb5EjjKhJiOwf0MWQJ3Nqwi6MGshfVvV4b?=
 =?us-ascii?Q?9yqmXDErCCUm85Y/wBu8ExQVawh7d2a6zE5M/OuL9pPuKHcRkPwQnoon30f0?=
 =?us-ascii?Q?luR5TzLzSYmOh7GTE8ow0tDdRyKNBRYmwcm2gbW6S5FAIyLmzmblW0jBtea8?=
 =?us-ascii?Q?XUHbgxSD6avNMSiR8Pjvmw8l7i8pcEpr6ADdpytVhrPpqdf0lvoFqeL/cNPS?=
 =?us-ascii?Q?xYkFJbGeeBz9jpu6ATgPRcBBhFtG8fmTGGQPR7koGBGT2izU6ewV3oWc9Nsg?=
 =?us-ascii?Q?qwNwKzBONbisXiKJ5m2Lj5kWEh4S69j3dnx1kRlj3BxeMQCi3E8Z2zijxPAn?=
 =?us-ascii?Q?wOz52MR7N7IcvT64kHrdz9KtfMW/y65hhp8sHt90NF/UV9PhlMKpheFr8jlS?=
 =?us-ascii?Q?mehceviUHcxwQW1w+zoZfinDD+2gDxzPjnG+d1z3q3baHteFDIUrSqWRVN+2?=
 =?us-ascii?Q?hHsKUmPG+2/JXk6cCM2CLWPT/E2sFdvXuIuw3IkVw/cmn80/q0MgmjQWXPk7?=
 =?us-ascii?Q?j32xk8rCmupJrorUyq5tpPC15NnzBsTsr32ukUN/REXxuUby7CC5GRhTYn4x?=
 =?us-ascii?Q?YgSDmpPP6j9fMWgyvF7Tr7S+tMp7TTQwGTD/1gDdZyfzfmJqujjgVZ2B7WRK?=
 =?us-ascii?Q?kteuM24soBEhMzHIk38i/1knD9s/czvrVETkX2jZ5r5mcMeHq57uvSnSR9/q?=
 =?us-ascii?Q?iJpw3bw57eBU7+f8N5B0HHzNQjf2bLgSVZTnVvTNrEextnpv399AYjrzD2cs?=
 =?us-ascii?Q?63HNkxeCjzMD4fkk7+d8ErTwNJ5Dkr+gWxHJhtGIPanx84Dr9bqkm4732hry?=
 =?us-ascii?Q?3YBSMwfCyF9Qhj4PPURJnesu0myviKlUnQOEn/g4ziOXbd5Zwr0bc/ArmmPI?=
 =?us-ascii?Q?+8VAc5WANwtj5A9MIsTfeIY4G228lB3EvifbKfHIg1h2jpUN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c007933-6c8e-4726-2296-08deb992a4a6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:47:41.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjcFtzmN07kJ4YjWhdcbrN56h/FTgXB21UbFMGjq4REdAufzlhu13L8BKmBwBTiKj6s1C4NG5XT6hbB08c0vsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291174-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,blackwall.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 299345C2681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:19:09PM +0000, Eric Dumazet wrote:
> Use set_bit() and test_bit() lockless functions.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

