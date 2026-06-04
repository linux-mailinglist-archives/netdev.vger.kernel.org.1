Return-Path: <netdev+bounces-295183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DMwIGJtYIWo7EgEAu9opvQ
	(envelope-from <netdev+bounces-295183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:51:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F03D563F349
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:51:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=s7BVO94m;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295183-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295183-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9904D300D358
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3035F405C45;
	Thu,  4 Jun 2026 10:51:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28463FFAA2
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:51:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570263; cv=fail; b=H61lfdQy190vq7Gh2V7v9trYk5W3jCKs4B/fXFMxQrkcOv3rr7+tA6WuBuv5VLbZ7J5sXl37XWmBrcgAjQOPKTr9mzdzr+yvFdThL7pO863baMpcJVo5K3lCkRsbBF1Ua/YlAUU0mLpwyEIY6q4W+LY/tbxXzdZB9s+CeVyXYTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570263; c=relaxed/simple;
	bh=fkDiIakHSI9RxqecpYSd9He3aDeWf0BTOyB+5LUh+Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K0WOTWt0RjQY7lWL+/Q8Plv2BQQEbLFAWceHfGLnGNUkdPqJyMHayOgaGgvFOrJ1iBWOm8c21jnmXxQUnux9Cmnn0VAoeqhWzCRutKVtaqpVBlDAXqDiarqgIRvuwHnXuhNzjK+Xmaq9RxG/ha6LCNU+kNQmnfEOzGogdymq0jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s7BVO94m; arc=fail smtp.client-ip=40.107.209.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrLxBkx23s3VNkc6zSdcrBAp/MD4r9zo9/H9hKmn7UCFFH04rAH3Pkq5kXvfucL6OYDopcvRXmKX7YO2bLul4rIZH4dvL2LE7yYujNNuGEKax5uBQhggaJ5S485Vezt8EmW2MlAjttN+Bvu7E1yOx71UxmyDVJ+vUzYE7N1bXhAJ9PQ9QJmlxVhMCdt2xEtr8TIJN+k9w0/xt4Y7kOZnUj+i/oIArh2Xxm7gMvVX6TO1u/PcEY2hyn2MctTUB3rOUbV9j8WOZlNQRRxZoXmX2+VArhaRCD2A5fTeQBHJIMpstnLgHD5QRUyfJeiQqsYEVGWBjlI0hGe8+un4xAMP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67saIYxOXjVHYKtpi1m00zLb6AwH3ps4yPx3zLGnOus=;
 b=Y/F9rHEf4WeFmngngIVrdQlA1JsDzhv6jprzSU6Ev5DA7c53kDtF/e4GhidN94iUMUxw+XN5+8C1p9YGHlhg2gHhu309KZ2cEFPW8+OaULYNYTSHW1E7ysUsrcyc5hagPFHqYobzrE33vOWk9JDZaRmPQy9xxDN4qKphtKLZMWzVC1GPMA2JqHagEXptY4yfRv2YDeRE0WclhIbScG1pUpgFDwbJcPhFVhOVD5nZngA7+81zsBW3VBclebtI0ZI3ctW1OtoLrTNSsma+TEXLSecxAeEcNx+w707cI6Jw1gKcmzbKc9XxyAfoui+wEYclIowPoNoPDH/QYpTm/5mIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67saIYxOXjVHYKtpi1m00zLb6AwH3ps4yPx3zLGnOus=;
 b=s7BVO94mm5qee8774LRZyK8v8lfuoMS8W9Hb4Z882iPd6GP6VgotThxrXo+9kR7vxoIWzmSNAyjz1e2RUhN1f/b46BwFL4dk826vRbwUh3kBa6+eHdiez/RHELsbho5X2jTDpMbZ+kerngRXX5WOyWu28ieEUXC+oOBgnliktWt86wZHqbysFdGqbgoIkbBtAUdzY3wvMefHLJJQg+MS1Z/N7qdsHht9poKY0KQIEVMG5gAQLvSmVTQZwyH9sjkF2Ibw8hxA5hoHbbKQykykGDi8wNLicRhqMmIao3IEiqngKsST+Hk5ecOw2wYKWsFe5uCIi42WljUsE/B4Wxp9dQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 10:50:58 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:50:58 +0000
Date: Thu, 4 Jun 2026 13:50:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 05/11] bridge: provide lockless access to
 p->path_cost
Message-ID: <20260604105048.GB775294@shredder>
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-6-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603062043.3911278-6-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 8126aafa-3813-47ee-552f-08dec227292d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	3q2Bac20VHnaLuvWW5g1bmoFSwu1hZ31HNOUOZCDme9eoXk1u3lQtpV4fyrxWCaKIRWIEiJh1jjMf1qgpLSY+QTZmRvvqx7IHLdaXxHhUuPVhJ9HjoWv8T3qOpnA9JFiMlY81bxFkK8A1sSF8aQL1/l/SBcJnNyf+Uwn7jqcMOnXur7y9znVrg0DVbTfpODkcyRiNXY96qepmTk3dog4kCXdyDAtweVxDttl6DHqqgQBr38LrAZLtcD5Gm/c1dt6GZoi6+YxXEkmF00x0z0auThK8Rf709eckNKELFqm2e9NlxZFpF1uhbZ87J9M7kxO6phyyCJrkFLRtAxyr1IR+Jz7v1aaSnw3KqgC50JQO/EoRTpb4QsLIBJLqeocUY+7AdeR2F80ZH+qTcPjnUWcGavCZyaIYnUo6d5Rj9Wx2gWbLxDDAz42o3iw8WjjhK06rpsAb9Np2D79Uk5HYtQYf+OkJbqQ84XkOV4pC+gQePbCC39XMr9PYR/qapAeM/yfSAhB9cnEwB0CAk4bpq29GUoyZUC5eaLOEtZcmTzw/72sPYp4dIwNAHmrMTTVnMQyZB9ATW8KUEaV7MdHFFzg3XLcf3D4QSuVpIBnop8ih0si9gDR7t4iptMgtnIZMmZ6iicKbS41q7KlZyGXuhndnsVy+3tQEOe0K04MmGYwhEpLGOqDtJGkwO2CArXzij1y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v+p4SBzyvE324HytCA+6mgimDR3StkTQYMLe73dAqYM3IlCQyxcBPqe2ZrWF?=
 =?us-ascii?Q?zjYR01moKcY0/pSjvw9QitOcqEBZQULoX4hvVPQytqxais+CU5st3gTj6al8?=
 =?us-ascii?Q?HoqkOXKwrs+9HzHAV957zpoWbfnGs2TeZm069DZDyGFdV4cF4tS5Vq5wVpfL?=
 =?us-ascii?Q?H2L1FPYElQY9whQHjS0OMh9kvATmnVQ/DFRhv+yMDGQgu6SkdwAsSqHmD/sm?=
 =?us-ascii?Q?NKGkKlP+62Vsn3JCAUJPNnSFlnNWDek3r/hn/9dpzC5RbkdvgoCb9iUxXCVY?=
 =?us-ascii?Q?hjyezrKkYHq5dIYCaWaV5aOz8BvACxygkzgN0J9oropXdz2RxLOJNJ5eYtRj?=
 =?us-ascii?Q?ZMXcroK1yhcjEbyCyu8CerDWfMsPiH5SunJH7JC61cs1Tanop/i2jDUwQavq?=
 =?us-ascii?Q?Lwr9mhsLZu0hKxWFvh+6Bio919j+lGoxVwyWBB4sGAhNNiXlNY9i1rDk3EzS?=
 =?us-ascii?Q?H3FMQW4EBZ+dfsUZNSqF+VK+lwDvItdMH3vHqMQCBw8xDbCEg5LOQhcROITY?=
 =?us-ascii?Q?i524HMm8aQJh7vbg43Z9YW7vnKi44owSlMCCJXR7NeO/JgLe8w+vzC0PeF2i?=
 =?us-ascii?Q?8U3fp0PTWW63Ljy98r2F4QfCqLT3S1yNF/2UobKAXuU3h0/KqI41Xf36BYFy?=
 =?us-ascii?Q?d3dvgXmqsyqXFGAtrcJ5FgxCrsCWiCEf1HA4ifH4HirqGlaNq3dzuwBw16Qn?=
 =?us-ascii?Q?0uCzaQ5BYTVdz4t8EmOJ4Ysapttb4/YzLsYtL8mSv82rlHSqRaypKrXa7KnP?=
 =?us-ascii?Q?t/zMlK8OEdd6rGdbIPsSIWEfi2fUmW2D6OpViGmSYlC9NU+S98zfeQPt50mH?=
 =?us-ascii?Q?nLlzPUTC3WSTy696lbfnHItIR5DHVDbr5kfUFaXgxYjTngDYTTgJFPPFKFaV?=
 =?us-ascii?Q?vBxVQTOis5uJODp6YJTKo3ujjFheHnrasdk8OoM8L0DoJGEVIn/tTkCmN3WA?=
 =?us-ascii?Q?DCEKDU3W6g3fl3oP+55VD34zab4BhMG/b/XfKpcsnlK1UcIFZVm5C7l1scGC?=
 =?us-ascii?Q?dI4+710jwk+y/NjLdhg6roLSTDmlkIxJXNmJzeyupyymi2SF7+up3+GVxvUV?=
 =?us-ascii?Q?v5gNfscA2+J6JEXoHudBer61c7+D7CXzV+3SOIFngI1XYs88XflxB6bjyir3?=
 =?us-ascii?Q?Xp/6kl0nDt92RsD8ofvwyl3tK2+FD/dWlvkY4/XVxIh79TByw+ysHC4VNnJF?=
 =?us-ascii?Q?N7Ls6KKeoA2xTdN1IQyWGErNkmbjxxMObvG9RiANjXQCuiX10NqxpY6SkrWK?=
 =?us-ascii?Q?77cDNlKCYaodqKamRHbpNPJtopJMTcfKhY/u9OJt702zbxtndp9n9+dhcYTT?=
 =?us-ascii?Q?3SaeOmq973wRW5goEf9RLyZKEnrRu3vvEVigYwhS2g3P4yajkQUjSxaISRLt?=
 =?us-ascii?Q?xBdpTHV1A2zfejODMVGNVPZmPQVo0fnI7uzxFYNzoT0jgRIpb2pEL7KuCsLm?=
 =?us-ascii?Q?yPEL93VMjz7QDpjLQUD2zPzXCqQiPsgf6amFGP7VKketKnBIzEbTenj/BDzO?=
 =?us-ascii?Q?RvHuqY/vqkYkhf3L5hnAFvu0gfdnHBIMlTlolFhNv/xQlOqqM3yRw2zJhouC?=
 =?us-ascii?Q?Wqedlz4IAz7Pf/J+0AFK8hShAwJ1xNRsT5NTNqoSqodQR0Io8enjZBfjk91y?=
 =?us-ascii?Q?baH6S5mW3fjDy0cizeEHn10A7iGLPf5svDeb5SFS09FOCLP64EKrMX8C0Jxd?=
 =?us-ascii?Q?TgYICDu262vFVi/9LCj+9bVGh4xE71voLBhXlF7BiEgwYILLsjxGwet9b2zk?=
 =?us-ascii?Q?hN/DY7cstA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8126aafa-3813-47ee-552f-08dec227292d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:50:58.5075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSd54TsaICGixAsWPNSG4OzVbGK6CT4zjJEFyj+/nvHWE0iZXtUfJyf4ivYKBll10xp4+F7qeK4Y2ah9Zhr+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295183-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,blackwall.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F03D563F349

On Wed, Jun 03, 2026 at 06:20:37AM +0000, Eric Dumazet wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations around p->path_cost.
> 
> This is needed at least for sysfs show_path_cost(), BRCTL_GET_PORT_INFO
> and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

