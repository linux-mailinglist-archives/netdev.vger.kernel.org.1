Return-Path: <netdev+bounces-290725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNDqJsQXEGoITgYAu9opvQ
	(envelope-from <netdev+bounces-290725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:45:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EB75B0B42
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37277301016A
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 08:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B403A5E9E;
	Fri, 22 May 2026 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iSokWE9Z"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C433A033
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439553; cv=fail; b=tX8rnndV6QU3FpwO3hY3w8hOvc6aMTzFJluZnVbQRBoYHHkujTq0UyIOf9Bm+kQJ0m47VnvkMRVPDVudFwkJXpbrmG192Yg6xAXaiWiYNDeIXf1tZjbleJhPwntWLYfmxrHxXKCWvlDnOylSkoC3OC+iPJpQf4SM96mi4bu5LKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439553; c=relaxed/simple;
	bh=G+nDYCH6G3AItx4W/rH7ZP3hGoowj61+TakEGpA9BN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IMSKfVpQluMJo8jQnetS94fJs1btTWENkwNplPJRhjzURzRsejVkwifBs0Cf74V/9MQczOpecgG9fxP1PNqcS/74+X6hK/lCdd0GLr4UBizzXlyUzxb5YKNU1dJUlAO95UbnLApyTlxeEoLq+lK1rJRXd15+s2ipA4GrO/6WsXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iSokWE9Z; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjkpsWGG+qcP4c5JDLUBeUeavBtxizMdB/0YxxWH+P0o+AoHw5ml9HX+BP0k2FQ5bx+UfCR7eGCjbYfRBXdKal976SVBjpX+DPg6RGUr0BzXadIB+K9LrcYr3IQSORpnkeRhSbeUyQBdZl0bTkfm4ljvmv0C4TLYxpAV2l+WgBVlUr14GzR6ehqPWLytZcDR6yAd//IgSPClAA9EGIn6+Bwo+3+DUa+YYZ/yAwJHg0nIFb0Mo35cbznQFDvjfPBnkg1prg//+GJ1HBJckKNcR3DytkuO6MOisUELf1RsBMsmlxnnzRHLStliJIcPucsNEx86nbuj13RWzAJlqTN8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Rt/xCItd9s/aFzwMcx47EvOvhGEen6+gxs3zFXR8S8=;
 b=QlMfODYS0C7MgDFqWIZaHuMP4/7w/u63Mk1waWpiEiWb8Bd/UIGPLInSlbDKoyj1h/JQbdGxDGGzYD94BOlAqDGSaHGXvF1Bvn8icu3Uyd9esbeh8tMp7gpjVvea5vHTm0wOmPY4oEkAyQKZQvfesTsXPJDN/Mrxgg8v5JJGl/0PuNibFIFBjN5TE2oJSU0w3tIbCeHi+GDrIVkkZNWMnNisPqSy7LlVH1xycDzo6EeZUDZysnTIlqnCUf1dlUwhvkQFA7TwtBC0jY9FK5NlamM0AUVyxmJlxpwcHydqIYoXdB3+4ZY1YODiEqj1qrwqBFwMm45MUCPME3YPcYqe2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Rt/xCItd9s/aFzwMcx47EvOvhGEen6+gxs3zFXR8S8=;
 b=iSokWE9Z40H7TRU8LPXQ+T1g8r1ocsqVQ4AECEgG29KjqkGdDwBN9K0NPZpizcDZ4qscd//TE30DfIZSPP+H9wiV9vdG4ktPjQv9yDQDXnkKD34GCcmE176kHPbD2PWJpKzT1Oj1uj62lwomUNYNK+JC67OGvwFzv0s03K1p0X7hm4lcfpY3o+WMy6/+daO1uzvucfK/r76VYpBYbDjYLMVeEwcGTb3oAg/fY7rGvHwMGaKHjS0JgRTKvoIAiqC5yLX2IDUzJIUaGCXmp0BKa6pmAELhiNanCUqplACsCCVw1Y43Tz7mS0l8JBQGNVZ3w6rUtK4mWPEb4ch1qOLUeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 08:45:48 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 08:45:48 +0000
Date: Fri, 22 May 2026 11:45:38 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 00/11] bridge: prepare lockless
 br_port_fill_attrs() (I)
Message-ID: <20260522084538.GA829572@shredder>
References: <20260521131916.3627204-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521131916.3627204-1-edumazet@google.com>
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d1f0b1-4dd2-42cc-ed46-08deb7de8568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|11063799006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	PbV7PH4pGnKmhmEg+JnGw5aCdLL400ByuPq0MgfgfQUexIg1Yjzo3Nfkqx6M6R5sKBdacDE0+WZoB501rFYa9VBkDaBFLplmr0RuHQS+NkfY4cALY7J7GBdDw2k7Hutzu+6vWjDMXt6O5eZ7Bgs6Uujgm2PaxISn/wnBCD75unc8r27azNG8IBi2fg0XllR8dR29o1dAynwswDM6eLo78ATmTbBn35dqlB0Yu/LuNeADqwPaZTwtnT09XCA28z8HhTEWdPAxbH71A05bcOrawdmmUCU119IY+L9qogFUcT6nV/U4m5Sq3hWgZ6m7fCchBvPtP9teolr2CfAtGLMd28azr2zr3+yMabJcEEGfxp7cjxc2VuMdOqTYfaNp9gT8uow86PSTv1sTaYnovvIitESmu3P0DM1dxgWoChNZsthXiLp8NE0mVDVZRAsy0ACSSkU9SaZoEVBVGhUazatxU/MNGWAxsMlkG/61KrEc+BrGts1HyauxayuqwQfiziUkPZlvySYnXbJMX8WPkNhdelMbQ/qqnmSCQ4DPjpWtdLxoi1MVAjGPmWynbloZQxrxGjhaR0HrB7boQ74A+1j16pXwjKSIysYBPhFsqdhkZ1y2kl3qgbYjM5Pjy8U4BMY217C7ZV94tHBv7nlokHcBl9Jc8gwiGZArYGm8JVkbBYlOj4YTnDOmbAVYdGilfZx/AiTbXw24bYKJK9Tc9xD00g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7agHKJPxsEDJP3AErXXCCM737f24pDAZtHJd3xSg35VtF89OeiBPgXDmknve?=
 =?us-ascii?Q?bBe1MpSdo6vglU5wig/NaJAFX05BLgucP65C8UHK8OA5wrv4G8jGMak6Hs7G?=
 =?us-ascii?Q?8UiRrpFrekmUAIbR4nfS07HImzCuyGks+Q0wcW+TC0KfnTsdUk4zQlidl5mw?=
 =?us-ascii?Q?sfr7IFEGxR74TJ3WH9nBRi1Ec26p/jEQ+1RN22T9QRFm4fc+s6MDby/m1IdQ?=
 =?us-ascii?Q?H7XAfb1TWEUz9Fm5RMxXPF6CQfE6K802SgJj8LnwXZvlc7mhjmwNxPi71nLH?=
 =?us-ascii?Q?VzqzH+x3mpCLnawCCM3RNSuiKLMjbodUjpfWOXa1xfyX3ps+Vp4Cz6q2ox24?=
 =?us-ascii?Q?PdVvKQa+tO5VrGiQykdyVlqCzRz/p6mN/mKUJdRcj8zhO61aIe5C2L7jyWEq?=
 =?us-ascii?Q?lRCPWGul+hHZTn2mmczV7OZ2jHh0uGGPZODlt/q7GiyDGVpwD8z8m5LBoO2Y?=
 =?us-ascii?Q?XRIf6VVizy8f6TbZHzB8B5vpe90fCEAxyXP8Fw3LaPJl8S6AQg3vo7tddUCy?=
 =?us-ascii?Q?MGs4jgyd/QM7V/ipAn2+yF8J54HkvMotN7D6P5PniEQ0G1SrObEzKAwX/cHh?=
 =?us-ascii?Q?uHkjcrvEdMUZFxKDF2GaY91U5DDpB+h+lCfYLJCfDNbogVwa7iZCXKtyuLgG?=
 =?us-ascii?Q?oda42BlDqr76gjoDeAXTSUZwQn+Yg2C0EiZ4Gv73XsDKKdCQPa/ESI7ttArD?=
 =?us-ascii?Q?sCP1e6vlBL6GDLt2C/fDozAPf9hBLrJ6mNgwVIw/uQv4z6EKcHII03ZKL97K?=
 =?us-ascii?Q?4PDGqhIBdKVm6h9PWvbGsp2kK6wN5wAveVnkFcIwMIMNiJnCuVDgNoRlHeKZ?=
 =?us-ascii?Q?NnGOwo+sazZ2gfJVKrA5+Fs6a8uFU222yLhxoqvmgvFMI58HuHbtZiqNSQ/N?=
 =?us-ascii?Q?tt7DkhjqA30IdbomkWOEsypZmNA7WiBclb6wlAbOwxCK6BhLdJpRC40QX/a6?=
 =?us-ascii?Q?5N9vGY08wp+/+XPEJ+KHRQ3InsPVtus8J+ZoyqVBmYshiJfXb1anGb1kKkOb?=
 =?us-ascii?Q?Z0JgyEjXenbGyFzDtPeF759QUxZSp92CUSsXtQhu2+i1OQ/EWdE+Eh6AuOR5?=
 =?us-ascii?Q?XhRZnd70WQYbRcUR+8CMxy6HsMd2BQewNEdCQ72SrIsxZpTxQFs97ku9jC3t?=
 =?us-ascii?Q?8/V/P8ZMVFk3CK8xONTK03f3dWGmPJ9+onC05i6ZngUYW6sIFJ3l625na/Po?=
 =?us-ascii?Q?GcnthohhddnaI6cSMfqFRsehsn2/izKT1/WVlvknb9ksD5AM8sNVJ2Xe6o6s?=
 =?us-ascii?Q?0oqYoXKL9MLFLZH1MYKiTRtXZjgOg31wzi7xEaUgeCwe2dpwiCNjUHzcc2Nv?=
 =?us-ascii?Q?87fNoz3lnAI9d+WyqV3nkw364rQIGmnN//cewmjqvg7SA0G5NNDHoKo98qAo?=
 =?us-ascii?Q?kTlj6VS9lgn5a6Y0F47qKsGKrlmM+35xNgGWXPJrsKT0d6Il/9aO3p9g7xZS?=
 =?us-ascii?Q?9FNi0+qrKJcw24toby/tJyCp/5AV8vKKxMNGkIXJ9hY4BmzxfrIDoUXC+j2f?=
 =?us-ascii?Q?GdxRt2+G+npfArP9I2nojBz+41ISS50ZDea85n5F1DCChUrOR+T61vzwSAYj?=
 =?us-ascii?Q?sxdt36zSNCQnhgzTli2n03OSqPMUxjXw2pdcxcqk+nrBYdbHxJsjYkjf0fu2?=
 =?us-ascii?Q?9ka6geR31z650ZogzJtWjPuH5tRK0yCWGNqcW7nZhXxfyIGhTeUAS8SVt4Pt?=
 =?us-ascii?Q?4FsqLvWJMUZex9NbfMCn1JVJJkULflhtaNxrtcO7chHq4Vnjyp/fX8D1HPME?=
 =?us-ascii?Q?G9xIiNmUqQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d1f0b1-4dd2-42cc-ed46-08deb7de8568
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 08:45:48.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfUP3cU+1abH6eMi1YkZf65hx57LmhLlCkK3Kqk+xvUPulNmvsJMV8mnQySH5BlZc2oRpkHlGr2I45x055Sg8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290725-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 04EB75B0B42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:19:05PM +0000, Eric Dumazet wrote:
> medium-term goal is to allow "ip link show" dump commands to run without RTNL.
> 
> This round of patches adds/fixes some lockess accesses in bridge.
> 
> This is not complete, more patches will come later.
> 
> Ultimately all changes to p->flags should use set_bit()/clear_bit().

Thanks for the patches, Eric. I have two fixes [1][2] that I am planning
to submit next week where I mention some of these issues. There might be
a small conflict between both patchsets. I can review on Sunday unless
it's critical to merge the set before that.

[1] https://github.com/idosch/linux/commit/3350834468428df21c279acca1c37f67e68e1626.patch
[2] https://github.com/idosch/linux/commit/dd63fb916cdeec9e69685726ef65a40b57bd74fb.patch

