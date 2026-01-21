Return-Path: <netdev+bounces-251850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNgLMn23cGlwZQAAu9opvQ
	(envelope-from <netdev+bounces-251850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:24:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D55555F39
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3382A6894FB
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0D3A7849;
	Wed, 21 Jan 2026 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LLqevsPq"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86938B9B5;
	Wed, 21 Jan 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994220; cv=fail; b=KSm8pt5kvO6MI6rJAJqFqtX0rRYRQHduDSzBcAZAY4OaPzcGTI5Bb5latrT7X7BKjS47xSdgtiOjg4GJBjAsXu8DwTv9G6R0QdhcgA7gZkct6Ac1q2lvYuCjQfKNl2rPBw1u/qTm5y1V1B7uy2bH8+OJ3fqC0ICBdmAQ/WcQeDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994220; c=relaxed/simple;
	bh=nIfxiH8Y2yYmkVBfP/Tqu2kaDkEFK7IedUknX6s6wjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ovyLP4yK6JFZ55aI+qoZdjVyUr3npJLZHfpvZ7DTqWGS+OwWlBm4xfUlQL0NwXcyu+Gmi0IsH7w6dG7ns53Vz4lUxX/IP2YGC7sW58eidz407h9/NkkAxfQTcVvcYOKxNauhfPH+5ukklGh+EFE6ZvyhWeHC8q9Xs+xVXm54FyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LLqevsPq; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+mok/wsoH25MFycx13k98Sh0QSyh0kiIBw9dn+v2E2ATLJNgn42a/CxpS/68bD9n8FVEmHvU4FX20BodKItzBLIZ0swLN+2/qZ0qHwOpOcUIulZ8E2qLPh8tHsbL7c7T0arp0wbZ1Ky3fwfwWoJI5Fskq/TjXBTn2aHCyRtBmiF/a+9A9ias6z+1Y6SyZiuvsK25bB6xqcnqIbc7ChFCcN3q0XTsDKKm40iEzTHvvWr8EkArRVciNAG4uP1fxHu6MEHAKr5uDP/vSsyQgpAWTug28cuUp3990nAKHh0hnuHvUmZ5rv3X8PhcXdyqo+Nk05LgqhWhKsmeRIwEOi5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIfxiH8Y2yYmkVBfP/Tqu2kaDkEFK7IedUknX6s6wjI=;
 b=yhTMy68/WkafeJfjsiJpg96tLOdP0cc6SN2vXiyb8WrZHYQ9uJzskc0TthLxvsua1MQKhIVBTTlqDxn36ILZqgLij5veNzIfHMV4YxkTOWh8LvNw4HhCc3q9T9ZadHpKaNH4vqu4IlpQXgW3c0HVwqHn44BxmeKXNF4+ULzpJ+vznuT4PCyVN4vIcV0rZxFpcTqmfyepFWd3alKcJpPkGqyzZJcvsdHKrdiZiR2wLg/o4IKwZx7uBRd11oyPP//nxD/YHeO9IGkWlPclFN6ami+3uWTdZGEeCzwwPKGMKRZIHVo6sYmHaxpYfXjIKv8H0VO6PX1YPJdQPguo0dG6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIfxiH8Y2yYmkVBfP/Tqu2kaDkEFK7IedUknX6s6wjI=;
 b=LLqevsPq/L8qrcVP5vkS1L5jMlbSE2ZtxRvDtPsX5KaQnmZtT/1GU0+TTHwelZDBvKyWQU5gTDsLmdorrxAjEOkbPmvQBMuTZPeZkdr+VrwOPl9I+ZPLU65J0LM5UWGm+w3TSLjdLiy8d5FW+XM3P59On3Hw9FA9hS90usLTmlkkSTqaUk3exT9fAU4DM11lkJR0C9IUnp1MlH11R6nq7qtRZDudzVrxNM/qq6T5IWox1HqIn4vWVaPTJDuB8RR+SP47GaKPeIaSDQYV955sPybw6eeGUTTt0balue654761bxt1RzZPSfPjkCWMQT4K2F670eqyK1TC48rXGaYNTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS5PPFDF2DDE6CD.namprd12.prod.outlook.com (2603:10b6:f:fc00::665) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 11:16:49 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 11:16:49 +0000
Date: Wed, 21 Jan 2026 13:16:35 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Carolina Jubran <cjubran@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next 0/4] u64_stats: Introduce u64_stats_copy()
Message-ID: <20260121111635.GA447040@shredder>
References: <20260120092137.2161162-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120092137.2161162-1-mmyangfl@gmail.com>
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS5PPFDF2DDE6CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 535a5ea6-9b96-4585-b5ba-08de58de91fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cPLBCkIpBqxJzeqe8DWgTu5comIbOaSf8/gInAVjnwsi1IvDXFZCu8Yll+R9?=
 =?us-ascii?Q?Di6x9s7DhEjKglpk0oai8ojH/d96kz4CfTXLPe6ZmgcFeJyXj22EMaM912f4?=
 =?us-ascii?Q?USQV5RuTMV/uyDdidScACHVy/GSoU2ZW9Dbz4Y/NU/SQjWmRkPK+BMnJN2G7?=
 =?us-ascii?Q?e+rSUaxQh2Y9E8x01EwNeBZtPtbsQiVUgZOFJipj6Kec3OU9Ovy7ZddS3oFO?=
 =?us-ascii?Q?L1bGqjRPk1S7qx7W6gqO8up6zyFdERmQdXyN2gIyKmOmh1Mbz9Zt9apTylxZ?=
 =?us-ascii?Q?Ag1lW7IeXpvxRj/4QBdoTeUnR7nK4ibDl7Bh/TNAS95LlVICyBElCJ6Gk3n9?=
 =?us-ascii?Q?ltXQFsS/x2ZKRP7SSHD3wxBP4fyj3tFNXo2lb3PdAfJJE9ztT6Bm7tVVfIdr?=
 =?us-ascii?Q?GhgA8Iswi+ujmukT01AszGmEARhyVFUQlZFtd9VBAQmh+GDJnyZPHqVsukTJ?=
 =?us-ascii?Q?66vg8LE+vl0SNmBQ146ZKdUCGk91ALVcerRLKUEVdWjWNwixqZB0COvMWwMs?=
 =?us-ascii?Q?7tgyOulZYHKk8U7cQTTLGkq6P242j+jyhVpaTAFHJBD5oEuWzmvAld7KXyF8?=
 =?us-ascii?Q?ZepLA0t2f7wsIYJY2/z0a/YnMxxGeKAarwJbsPQUbrsGlSv0t4hscv8MhOXB?=
 =?us-ascii?Q?4U+TQxMak1P7lGkJqhnjxaWEIOuHbv9zO/mQy237J+I5R5xXf533fP6Y5p4x?=
 =?us-ascii?Q?cYqtBtmpIaYBfGPviZxNFVBlI1AnzHD3yH2Kwgw0DL9Nmh+ArY8RcIbKqobx?=
 =?us-ascii?Q?ZJ5fmV+BmUbUso0EJB2rjBnSigfo2bNW2DB2ElSkh38xFLal7YrDAY+XagDi?=
 =?us-ascii?Q?O7wtPchULwlxMk+eNLUl+bBCQVaT+OrKEeIpwZvie8CQQR0LsGEgx33v37Jb?=
 =?us-ascii?Q?AUp1w/DK2isTbsgEBXZcl1tBL1yfGQGCt21LhZ8YZeziVLo39bJZuHROQIT/?=
 =?us-ascii?Q?NXiPjA8taD5erA8qdWhK+ejszcE99ggnMqB7jn0BPrbyuCq9qXIZst7SOR1v?=
 =?us-ascii?Q?qgOsMo02XGXOrqrWHgpt8kNK46UBpwxrXRmS51HHPqzu4+w6CXA18Whk3Nc9?=
 =?us-ascii?Q?Ayoy9ghEpRmlADdTxdtTj67LDxzyv6BncpvgnoBaZTPok1JZuxTt9BGhiKiz?=
 =?us-ascii?Q?jYfqqvC/PeWkIQJPhjUgBZyS7QZugBI93VQIEWnspRRZhIqz0lnwjUQPFZJM?=
 =?us-ascii?Q?urRsV6lb3AfV18svJf4/wFcqrq/5x726u95gFfiU8hqPj1JQ81RAjOQH1vY4?=
 =?us-ascii?Q?U3PLF17h4CHyDMJRQurw4dPfXZ5cKhnzhp4WRYVvdLHDiOM8ZiiTx0f67FS9?=
 =?us-ascii?Q?AaeeoCCZucYtMIpVyC4QMR0hHZl2hYm8JwxkjJPfwMDaNVcmLq7bDCjT/kx7?=
 =?us-ascii?Q?x+LphPsbhgWRM3JXwUr6fSeR6Add8ATwIPV5ufD/wIfexbfo8NDu8CVCDRV1?=
 =?us-ascii?Q?VwkWA8vVfw0kISpKd6svoOhAsqukxtQPp5I1JRVskAXKz6ywb9DyiginDszZ?=
 =?us-ascii?Q?u0tEKpbGKarHUv79pIpPXZpHMtTnfFBdHhFCuFEQIodcn4YvSsZaF3JTZ3TI?=
 =?us-ascii?Q?pmC2SbAHFRpRiVIQzc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GKZVuOOBcdqA6mD1V46PutYNLBdCCmFM/nff3vDaDlNwqMsLod3eiSNAAHLE?=
 =?us-ascii?Q?N4GXAXdl9mUVdYmSUGt0sbZUk5lBv8tRsa1S2G+32PnzLymydVSUWhK++o6+?=
 =?us-ascii?Q?3ShGwvO7/esf9UXr5UUxinxqPrSPP711irs48o3YHupTdA5wYcCEPA0xvtXK?=
 =?us-ascii?Q?OFzUPFDvbNJKfYcdGDT8Mcu+7f4twlzHxxFpEfhtgmubeuGJh3VGvyVYbVBH?=
 =?us-ascii?Q?FxpLX9QhCoffn3CS4BRhUTWGPy/NqYzcefIYSliX72LUhWHUTjBMaTQRlNto?=
 =?us-ascii?Q?ljx9/xqkxNz+LCf7roe4Zpv2KrzmxrtkoPVIy79Dq1zrrJzSRhZb2wJ1HopD?=
 =?us-ascii?Q?cmUyJwVzcHGPsV6nIAMgsqLHvOyxzF4IZQkfMepP3iWq5nkem010cjMKuZHW?=
 =?us-ascii?Q?5+oSqjerS0fkvCW+7f1nBlULFcNKyRs6gR2pYKVrEUqAduwaTvvP4xdrYGdX?=
 =?us-ascii?Q?x1kek+6giEB8ukmcdTDT7px4WKrEEiwSkeSgTe5f2tV6mGGlpmID6X41m5Zy?=
 =?us-ascii?Q?ZxIB9nCduIV97CwKU6yNpo7nb9vQ3utOah2VjR5KyYur+cO+YAJnvK/CpdG4?=
 =?us-ascii?Q?Z4Y67PBnsykcNIPLUE4ylNirAeFb4Xtc6XTFPdwoQOjqSWxkAy7ynnxr131U?=
 =?us-ascii?Q?G/29+kzwRavCxlK/KeAxM7nym6L2xgmjTOC65WTZ1huaQLEDX1o0V7NZb2Yf?=
 =?us-ascii?Q?wx08nrEob3H/GK45FaFWyU0/SZvqMalKk2QJAFGN4wdFhTFCDtrb3ZgiC74z?=
 =?us-ascii?Q?MdnPaWQxUH67PXLQCRSVN45F1qLoRSrFZD0pyIC6wV4v6V03xJ+5y8tooS89?=
 =?us-ascii?Q?/g0szhPgOZKxbpEMGRHWZ1gGbfKzgSHeHuYNBNG0iTJukpl07ohG1Y9Y22vj?=
 =?us-ascii?Q?Wa5qbXHw9IUdn10YjWANGMJrP9w2C66p9cmADj+lU68jWk8x67L9U4xYYTp1?=
 =?us-ascii?Q?DWbmB62AyQxEiYxNnTCJ822/+1Mupjerlnti6h6DEvZaY2BRom7J4bbjO3Gc?=
 =?us-ascii?Q?U+ql5XpQTrdQa5zLESIRB2Md8vxRg1SmqsJDm4BS5RYqgxpE9YApV/b67T08?=
 =?us-ascii?Q?yZUJTf2KmSpCz1kZrjd3lf95JVZRd2hcng3MM/Fia7h8Yx57Xi0cVBLjsmZR?=
 =?us-ascii?Q?wn0xG1gjmcXDkWPkOWDuwmZwIw5YqXjBJqOmC+6tQI5ApV93JLnNZcOM/Ym6?=
 =?us-ascii?Q?PgekHdd8mxtA5mU3eopudaJ4Gt4ysT/FBXRFlBivqddixj+ReV9OAKSBaeFq?=
 =?us-ascii?Q?+nU+ZDQUgqK6WYyoC2NsiDkM6onu/IQV/cVxgNykcuVNIjvri/F01OkICt2h?=
 =?us-ascii?Q?4Vzj9/qt7ZfQkAudxXsAiDJUwv+bAg2Cz/5BOqWsfsfa9H0IPgBmt34pf+9o?=
 =?us-ascii?Q?T/vXOsJI5aIqyeSUd1fRsQppSApEnixq9GDxdS5c9asHm2yZPVgrbqPwoOJH?=
 =?us-ascii?Q?prEwzOi4M2thdTU563/IC6bc4oAwvo12D8Ls3mEcGEu+sWROf/oxdXl6cGi0?=
 =?us-ascii?Q?zdy2LWr8E7kXRDXDMNIfJ1Hl9QkA5iOEqMCbJCpOvX6FI5JtDu1Qe7zXK9JG?=
 =?us-ascii?Q?l7ZX3SVQRFPEzocoIoAWrycYHMiyQI8LwxxrViOXDPdUXuEiKq6xpDb6uo0Y?=
 =?us-ascii?Q?IcY8Kv6awBuj+aRwhHwuJTEfCD3TJnu2mT2VanCVtPEhGVVAY0K0MjDiQmJ6?=
 =?us-ascii?Q?uFvDfNhu75W5x/owWMNi+YaqalbhgZzGcbBZ2TUhol7SidsT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535a5ea6-9b96-4585-b5ba-08de58de91fe
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:16:48.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcXUfVpCCbGqOdVgog9Q92SYBpitqU0r/dzXNEoUmtvLohKv2aIMxQzVLFbBfJ2M/MqPTg2mY6kD+OlXadlCvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDF2DDE6CD
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-251850-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 6D55555F39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 05:21:28PM +0800, David Yang wrote:
> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing. memcpy() should not be considered atomic
> against u64 values. Use u64_stats_copy() instead.

The existing memcpy() does seem problematic (even if in practice it's
not) and the proposed solution in patch #1 seems OK to me given that all
the callers only pass structures containing 64 bit counters. Couldn't
find any more instances of this pattern.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

