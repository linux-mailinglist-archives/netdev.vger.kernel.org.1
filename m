Return-Path: <netdev+bounces-295163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0PpRBI1SIWqLDQEAu9opvQ
	(envelope-from <netdev+bounces-295163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:25:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A329863EFDB
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:25:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=B0j8Cz0e;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295163-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295163-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F17C303F549
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317D35AC1E;
	Thu,  4 Jun 2026 10:20:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DC534CFD6;
	Thu,  4 Jun 2026 10:20:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568416; cv=fail; b=AwXDw0kW/xBsXrBH3JXK4Yj3AFyaURc5iXcPPK84kMlY1XpTgplGVI+ffAwIaEzNFuNplt/RbO93T7IAyEgXxMQSudGNWKScAlaocn53+7v2M4VD4Y/pJT9q9ORS0QfLa7PttXawfa+gAiJcOa0gu3noqHtSMA2CM/BRzEbFkB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568416; c=relaxed/simple;
	bh=blIrMYwGDWV3DPP6eby7wqzWk5FrAKvXJrKalaEtyfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=co9ZCjrr6ofM9/K44vdISO2lzHtri7rS5RcKMJ0A6HMwcag/QR5Z0bd7pCoH7qgSHWl7jKjiYs32q37JkdOoL4YZ6ZpuBaudH2DE2G0CYpVO8NbZ65jE1qInhhibRQd4SLUuMi87wRn8d3yWadVlnSgpzV1RNSsOYbv4lacZngg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B0j8Cz0e; arc=fail smtp.client-ip=40.93.196.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmY5flV+XEXfbjrszaFTb8DPVYhVyU8uF9mnIhB8EuPvUCehCJT9AuzdO1WwRHdMM6+i8SmS8IgGeYnVnZ0zRsT7VJv6MIVfqNxJYg/CeKSixm3WCMzxTUMigtU48P9odgwb0iyqJvXwR6qvQxtb+Rcuf26A443tObTrrfm3fbuo6muY4ixEyyNSl0cBi/DLHX2zsyB/fa9TE+N2Xe5VqJCF6Q4KAZhN3SAkJ7KqStKUEdFbL5OiSajsuUDPSGV++lKl4/TISkSIdQyETPnECEuz1kQfP7DKELzMhWb7UJPEa+IFDSTqnxLoSPA5Ks3acYaZ9fadI4PaoL2BBgBh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF29t3Nc9sbQhH15k99bF6cYE+yIxf+OrSRv3HK4k1U=;
 b=WdUtnGhQjAoQwgrH1gr++dHR1ZtCXx4kg7JhpnJbskZ/tRq2R+S443UitHgOO0fzvlyl2CGwhfnFVpOBZMUkq7b6eIyBaNuAFB2FiZrjkAn+tEDO6DlyIlRo3/Ox6RhGX8/oJfVBmP8wUecKI3sTK8utT5igEsrkZUJtimCN90//9PgFodzihQRy63FEM264y5xir7+rNXAP8Qvljvp1rYVES4uzdBKYZBFoT7fsKoY1c5cBhRne/04y4bG/Pe0yb3D2KWmbv8dDpQ8+uZfAQsq64K3991PMjOhtT89xQFx4kno0SfePgL/KCIO659IBJDPOqc7CzQOk2wHwIrgIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF29t3Nc9sbQhH15k99bF6cYE+yIxf+OrSRv3HK4k1U=;
 b=B0j8Cz0enW6MBqCnBUC7y2jkmUgOgCVTkB/RGmvxgfR0+dEjV3BpCxyXAl+QNGhOarYp12xkzs+g3e0iABu1flAyXb0cdfECs2RjeQLhPDoltsTG+qwTQg3SmsAX2wJtf9xXxlrZ49LvfrErYZJytwO9AmTDmoU4/RkLRCRHhN1UVu499Hm2anIllENWdNAbv9VSLv2/HeclzC98Nof2oNxv/sFzmMeArQdaEYKiJ4Hy2GYojsPpZZjipAYAkNHeQ2jAgx16ajH7JkNEKSicBgSDZTvP72IW+JoekqNolAsc5QOq1n7Zf9bzP70YkGiDcors6Cr2s6h7itFpe4Bf9w==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 4 Jun 2026
 10:20:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:20:11 +0000
Date: Thu, 4 Jun 2026 13:20:01 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] ipv4: igmp: annotate data-races around timer-related
 fields
Message-ID: <20260604102001.GC771160@shredder>
References: <20260531030705.3754389-1-yuyanghuang@google.com>
 <20260531030705.3754389-3-yuyanghuang@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531030705.3754389-3-yuyanghuang@google.com>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a5a87f-4fd5-41a2-db90-08dec222dc42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	RnEhAYXex6/33VmeSMmSfzrqAUZT4SH+UoP30mxsnIaF9+xsBz2cpHRdD+wC9XNHIBRSyw5SwX4BxIigsvlLPLZ86VL8CWYFDnL1GFhhndX2fmtuv8kAJRj6F2YQBSuCiAK5znyffQkxMnfRwStW7Rbk1l/q8F3FDS4f6GJJ74Lp1Bh4elMKqnYtXZnZpGHGwLTtelk4jbbRzeXZr5FfXfPy4lewv+DzWCr9dc6xXUArLS75/VrpCXmQXQB3lvSOUg8XjBidrweR7oS0GTL0qF1eZAlh+04O8/T6sV8FIn0QTNPsLt30pAUVOsKBV0a/qSGc/GqIDxCBk0J/ag+ftws4XEeb40eFUNAst1aliD3fWYz3kWXazJOrVJzaBClFAqHifxc9jvdxqgrBvaUl6/hOVsRoU/pAcdj/POv59FWRhMreZXbqzfrBVZda0B5JT7r4zv48zW5MwXJpsl0QgI0hyINwv4dbPC2CGwh0WISQhU/FEumjqAZu+wM414e7BttBq5KpxuqoFj1svuUMGyiN7JTUVjQ+GTKfgjhFYW4/efNofIkt3l5B1R8w/LvoV95J2YQw0TJUtMPZRWNqpnA9i60p8mBDnsAlkqkA3NN/hF/PBW9J0/bxDOP84fULSrdBQgHYVxwwVv0W8uanSbxEeDnVkKjbvn3B9Hn14iRI/vkkhgZuJkunsjLcywRo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YYVyJS6uxhP+GmHs3mhVm1cGMkcNLzbqxyW9THklFzNte5CPyKLtdIGKWesW?=
 =?us-ascii?Q?J+RaE7/pvqkrNwYPbkCjeQjFucf1y3Qy8hvPs2pVSzO7WLJdeyM6Yw+TFDOJ?=
 =?us-ascii?Q?o0/Q7iEcg2EGbpPqYohcOqcaX55re9FqZzZx46knSC+mFxvq8G3ZuMce/UhS?=
 =?us-ascii?Q?7KUdAsVTXIt3oeUC2PlUS6Fil0RtsTg5RQ6xiKy62HjrhTWr/04+ft86kVF6?=
 =?us-ascii?Q?KYJSipPXe4e8DF6rFKUPVYMLozxPHg4KF8z0DTqYlk7UCBPmQk4uiZOhbeYZ?=
 =?us-ascii?Q?aj2v6UIT3rnX1p/McpCixvjoeJNSsIG5rkGd2ejb3Dv6GjLQJURseo4+PJMA?=
 =?us-ascii?Q?xuefLgjRThcpq68qJ5sXxZ5u7jaBFJ2LZTDA9UZUV/rDvpViqrmRZFyq1nBT?=
 =?us-ascii?Q?DgXFP1GsfD67afUVwDrESWwLYnyDB6dHb+IHciMiLbWEP37Roe1hhDQe94Jp?=
 =?us-ascii?Q?GaWJlZf6WI5XudfihzdnjCgTh7TWk2NhDCJrcQBRWZyiXVbfoqfhJElCLGZK?=
 =?us-ascii?Q?r+eAuqIrPF7x8I0kTLpIlQsYOPy5DJ21jqUAR2WBj4XEn+mncwMaoNZssLxA?=
 =?us-ascii?Q?o3kIizUc4me9a9k/Mw1D5GL/JPmI+BpEZjgwf6E0lQ7TjO6nJaK24otGkjQF?=
 =?us-ascii?Q?b+ZpFJOaWsD1Z6WRWHSZI6zG2652ICRNlGQVCXkZMPpzXevlf4g2fp9bPD7I?=
 =?us-ascii?Q?f2GbnTH+tkrVaEbwNoWFuAEk28lg4seYBr9vgimMMn60kiEUYFS3LaN01MaS?=
 =?us-ascii?Q?bfP/Hv4nYdvdOkqWEJcLhrlEUYUGmUGbZdLcx1zMQEPkeUGYLIbG9MEuxwue?=
 =?us-ascii?Q?dtgQ9Hu2xfi3JGo9CEOdoz8AUXtqKHpmRJofWDtoIqo2xoHA6dA7I4aUWj0L?=
 =?us-ascii?Q?J2/F8tFsudhNSI8/aB5Pp3nd6qwWOa5FYTcaZJasFvbJeftsS5xDnYHvwBPo?=
 =?us-ascii?Q?12Qw9QJCdV2w6Th0IjHHC5mVTKCMRe/EXnaWrK4DUQk4hOAGaNLskCUFN1dY?=
 =?us-ascii?Q?bkkSGXdO806d9C1lX2NxVOGaPOJLlsGh1JV4Jv9FVVxdNCoRqlZxrI+92tDp?=
 =?us-ascii?Q?AN/6sdqqCQgvjtTBlTarlVSAK7cTX3IeISN1ZLb7zRpQV2w2vKUcfLcMVXr1?=
 =?us-ascii?Q?48Y7soXd+mReOpEV2XAdU46fpwIcQlEewRBLY6PUJ2eKvssTXjtCRh9QTlGe?=
 =?us-ascii?Q?pD0r6GX5auHhiAI/lPyYxT6LuJtlX3aLrPWu4eBu/kvGEu7QXOWBtoeqFdnD?=
 =?us-ascii?Q?KxEkTTptfBbhd1YWBDLIhYuDFwfhUZU323CnGiONj7P0tes+9lfes3iF3aQE?=
 =?us-ascii?Q?TuLTXg7ZTbINYbUIWtEoUoNDsE6DJRXEPEazGUxku2uHHpBIswZckCovD6YB?=
 =?us-ascii?Q?PDrizQXkdQl1ul+qt1xNuVrOHWquA55nf+7sh0Z7Mu58+usgsjBTyslpQ/Tg?=
 =?us-ascii?Q?/72WX1xoHwwTKGCerYRdYGVJ6Am/8XRK/ScN2dRR9eJEhFa702LP5gbdbilv?=
 =?us-ascii?Q?j7wBNy5/BX62U+ltgDgiqPEPZHx+i2iNXkI32gdm8FC9EmSgNA9Gi7diIt9y?=
 =?us-ascii?Q?7H79uKZASVpprlgBQoLcsZRMdAUySWLd+Zgru0+dZAuIXl9KvL2E3/7hboht?=
 =?us-ascii?Q?X/MSpjr17rcuhUEWgOVg0ygsYvS86SaaabqLOKhHaMSiy5+/ITMh3RELw09K?=
 =?us-ascii?Q?XsngBPcpYnPLVPKI3TSTsxItJnqsqi658HmzlPmn0/3/DuQLz0vktnhDaiFW?=
 =?us-ascii?Q?Xevrv2lztQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a5a87f-4fd5-41a2-db90-08dec222dc42
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:20:11.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRLC1OJUW+ytKj3owH2Cs0xstG2i5ldJgBoCK1r8tBnxER5tLv1K7uYQUVurZmP4DwNDc/UHf80IxwLk7JguhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295163-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A329863EFDB

On Sun, May 31, 2026 at 11:07:04AM +0800, Yuyang Huang wrote:
> /proc/net/igmp walks the multicast list locklessly under RCU and reads
> timer-related fields (im->tm_running, im->reporter, im->timer.expires)
> to print the timer state of multicast memberships. Concurrently, these
> fields are modified under im->lock spinlock in timer management paths
> (igmp_stop_timer(), igmp_start_timer(), and igmp_timer_expire()). Fix this
> intentional lockless snapshot by annotating the lockless reads with
> READ_ONCE() and the updates with WRITE_ONCE().
> 
> Fixes: 1d7138de878d ("igmp: RCU conversion of in_dev->mc_list")

Pending Paolo's approval, please drop the Fixes tag given the patch is
targeted at net-next.

> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

[...]

> @@ -2964,6 +2964,7 @@ static int igmp_mc_seq_show(struct seq_file *seq, void *v)
>  		struct igmp_mc_iter_state *state = igmp_mc_seq_private(seq);
>  		char   *querier;
>  		long delta;
> +		int tm_running;

Nit: Please move this above 'delta' for reverse xmas tree ordering

>  
>  #ifdef CONFIG_IP_MULTICAST
>  		querier = IGMP_V1_SEEN(state->in_dev) ? "V1" :

