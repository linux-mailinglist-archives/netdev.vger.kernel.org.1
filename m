Return-Path: <netdev+bounces-261919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHn0NL7PoWkfwgQAu9opvQ
	(envelope-from <netdev+bounces-261919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:09:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAD41BB3BE
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8046030C364F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F6135A391;
	Fri, 27 Feb 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a9YZslkj"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFEC356A2B;
	Fri, 27 Feb 2026 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211743; cv=fail; b=WoBwOs8lASj6nbmxivJoivlBovtwmfSH1woADTxtftDfO7BjHCVJzwvLXgGdHSVC7NyPPrZUI1Kkq3LHa/KmIlNDFGhXOOdxk9ij2oHgmplXlyIm9fv4w4V+GcseSf6h2vP783ap7rHRgSZ8j8/iG/XmDW4bbVo8QfgBiCHdzq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211743; c=relaxed/simple;
	bh=Hp6agnXHnIeIw6Vjn63dYvCL2IAEf5T+xNnZmcY9884=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=sY2K2SHdK7XFxRPmwoFFdN6tiZ/6sftpaCiX17T6SUtHjZmBa68kgISFZR0LFXG/f3kDNXwPVUEY2R6nyTQ4Y1x6dZBYNPSYhJsaRmG4vtGZbmxZAJgY+UuynPJ1yeZVAjgh7SbznktnIXHY8vucZ+urDW8bewgyww6eU6T2jlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a9YZslkj; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RycbQ9XKMZ19qwa1sp8MD3+EmvfBvZrAmpRi8dhXPdvpI4HSeJ6p/oPgTDYiAHCxrs1rZvBBEJ6bYtpu79s3G0lXg18nmMA0yuhd5510L5TioyCo7RbuP0/Xr/QWMo+yTOV4RGvAyer2f33DsWzL5cmOY9irmN0dDWRrk/a9eDVevKNAVPIq9cFgIAaUcFw5Zw3GG9TqVOLh9Of7R2GjsE05+34UIZr0PQvDhyg9zSAy4fzpbCt1XIQPRwz4AHFO6YCPE0yXbgbzdKIpK/gNF2CYbBZ+7cQN+nOQDcaxoC6qZjjpRxITjOCcVvlYtMGEGaKe5/HculheY+tDBAxUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQghgffv5iJebj1pfqn8u9d8tizwe2OXraV7xngOARo=;
 b=FXDhvnotGwGFkqQ3G4kIsAeHUTo/kI+wDr6fTipP/r2/gjjX4jFbQcMinKbE5Qk1K4KRoUTqGV7350amcaoiFobSUEeG4LChTcIwqFkKRiG9YL/mIyeViq9RFd7gCuyf7yj6AP7SHMYRCckx1YKjKc8T7yo9KeUDrYiwsx11JEXrNGbw+mXsflAEoEgTtG18RHjyIiNrk8x3yDWP5LhSFPwucZ4+kxiaPrtW6mONjhH6DfJ9x3OMd/RWqLIucGcUTqft/uTQ8F8fxGWsXPfAu5WDngjYh4j68XbjcQBVytGLHuyS6v6T0tMRKggThO6t40w1eud3Fxc1tfPEan1bvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQghgffv5iJebj1pfqn8u9d8tizwe2OXraV7xngOARo=;
 b=a9YZslkjEbQ10NDbClq92nARztf0T0OMTBL7koZepQiydbbN0zLMGhbIktBgy9C4RtUClL4LTp/5ZNBdfXACDRE5M1LjthfPqO6EZN7WtCazl2EnRlnpOnPpB7CFgCWAzQvUJJatzquDyEswRB0//5rKiEOM9bYKSW+Lk78VWiRG+zgAEFavkPL0t17vYf2fBykljhepVa+/vkYbcHO3z1/xPIEsGydAWlruPt5iD/n91acf/1W4F+/Wuy6e6y85DaXYBsbBtCqWXFhmbyd62A6q6ZVqQXkYLkmWsBa4RE4pkLzYUkASIUQNdiCn1K9swCwZV93yaPeMIN1Er4JjSw==
Received: from BY3PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:39a::26)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 27 Feb
 2026 17:02:17 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::4b) by BY3PR03CA0021.outlook.office365.com
 (2603:10b6:a03:39a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 17:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 17:02:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 09:01:49 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 09:01:45 -0800
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-5-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 4/5] selftests: forwarding: extend
 ethtool_std_stats_get with pause statistics
Date: Fri, 27 Feb 2026 17:38:40 +0100
In-Reply-To: <20260225150648.1542206-5-ioana.ciornei@nxp.com>
Message-ID: <87bjhaf7d6.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 148438d1-a100-4550-0a4d-08de7621f62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	7KnvAJJQO+VUOyOswAqFuUDz4yhHMdBx0z7ACmIGw8ha3Y05sPU9rdw08+Q9TUwvoznmfW5duJpeTBQfQqIpwKptlRPSZncV2z2mo9i2xXlvxjPvn+bW5jJ/CNTzsrvvcUQDGxRBWy3vyZnt4IyL34ZJaZMf+dtfNMuszu4S8calvjM3T4cgdBpV/rnkBf+4Tj/D0HsQY0WDhPHM6l1ADCIou9H5j+d/AngUTKaU+05uUbgu4HHMayeAKY6paY+0y1Tq5S9VBkmN5sQmsAuSWkpQ9sXqiHYqMcslJnHg1nx6C50+2GpJWAsEG24nGF7zWq149EwzJMHARKuYEy9vPGpm/QGnrJaBGf2KyTEzoKOcgN4tUqBhilX9UAGpnGVi/SNFKuzHQMfUb+Xef/wb8WfshPsjiaeD1jVkH/17N6ywiYcvehurCumMRgYU511mF1mj17GeS2VP7uROdVh5cltTbjUvdgzsLBWZ66T50VMW5NVdGG46LM9eworD6T5gggnjm+j1oC7iuKCQnYQXLQHBrGCPfcQjCTEtle09AitRF6SZ8qG8Aikrs8+IozAFQy3Qh3/3inc8EhC1I4yPdKzDCvE1TjKZccV5YQjeWJTs1xTptRlMlFdlOFcGyeFoo7RVMynIy1+H3/QpxzMQGn8Qhou0Q7w8G4DaWgsJPCWCf68S+7NKylXkPwkSSgjUN5DB8VFIDzSeJnU2r6Lr30kFAL/GIomq7f8xHzJHdzmTZa3GbfeZnVbN9fFvB7QHBQEVN3P4moar4KOMdcoR7dn5knt7lxXIhLuOVOYhyFTRKOj5UH4LjY5fTKuWNDgkFH/p0QWVk/cnSEo97da46A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zfFx8h7nyF2Xi61RpYxixIhseiCLNUNxfMCFnA3lU/ymV/gTL2gIdUkG4Ns1UziVb6rSug2GDtL56ZmkgLn1bXPJlW9HbzMyPGYD5MZRKivhicTSrlJa2ZATaSxL5QURNiNKgyZR6QOhnS1UQP9hzqd7hkq/+HvdjW2lFBBKOixvBlquhVRRdbYXd5gkI4M6WSwOfcmJ8HkP0Rlji+1lpTHw5//bHESSNxhdUcwQlfv2gJ/Eqcmz8T1Z0QLdwaBYxSviaaPhWNM6QlrGFCvgpdwCR6aSzgsa9ICJIE/5rHUtwV6B2u/jFNmn4Rg3Rm1sqvwciUGLe+RF+ohf0iuXFmX+MuRsclTboBaC0BFPNrdd2RQjxusLaCbwSQIHVeQukp9CZ4w1ws9jFklmYOI1r1UetPeA0FkfjgUijphUz+MPZ5/MRBfdqrFgDZoE3Jno
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 17:02:16.7952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 148438d1-a100-4550-0a4d-08de7621f62f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261919-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2BAD41BB3BE
X-Rspamd-Action: no action


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> Even though pause frame statistics are not exported through the same
> ethtool command, there is no point in adding another helper just for
> them. Extent the ethtool_std_stats_get() function so that we are able to
> interrogate using the same helper all the standard statistics.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index a9034f0bb58b..efd236ae1c28 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -831,8 +831,12 @@ ethtool_std_stats_get()
>  	local name=$1; shift
>  	local src=$1; shift
>  
> -	ethtool --json -S $dev --groups $grp -- --src $src | \
> -		jq '.[]."'"$grp"'"."'$name'"'
> +	if [[ "$grp" == "pause" ]]; then
> +		ethtool -I --json -a $dev | jq '.[].statistics.'$name

I think name needs to be quoted here? In fact, unless the pause group is
highly unlikely to ever get a key that contains a dash, it should either
be quoted in the horrible way the else branch does it, or do this much
more readable thing instead:

        jq --arg name "$name" '.[].statistics[$name]'

> +	else
> +		ethtool --json -S $dev --groups $grp -- --src $src | \

Since you are touching this line -- can you fix the missing quoting,
please?

> +			jq '.[]."'"$grp"'"."'$name'"'
> +	fi
>  }
>  
>  qdisc_stats_get()


