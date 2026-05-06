Return-Path: <netdev+bounces-284895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uItOJ85V+2n+ZQMAu9opvQ
	(envelope-from <netdev+bounces-284895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:53:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1B04DCA65
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6162A300B54A
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A546E3EE1E9;
	Wed,  6 May 2026 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i9cZk5rR"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9273ECBDA
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079075; cv=fail; b=L/hE+5EefwzfnigcEIde8ILrYylBSaopwkWGlRghHgu6ZEK1S8jNu0w2SLnQxGSiBjLfjglggLsQ/n5HmGIzsi6RT6H44R/ecc7xsF4GzUoWlwAGwFCNRkz7ZLgX27GmJNMJNG0NtTAnRzZMUd+qJGdgQCTvnBPp6P8jK9PY7GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079075; c=relaxed/simple;
	bh=gdcY/HRok+cCbPjhHwb3BV3nuAfxqLAlM5cJ+xN763I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X/q7SFaO9UldiCQLOwlJMjizx6SBv0I0TyA9OYgGRcjqpg8I59iv+5uP9NwSln6PkN1MhyIm2MynkB1QbKo/FkE92MIJ7N9FUSgEU08+WzoDBrTfQRrhxJIpJoO5AQkM69fLP6VjyWshGKFC3Wn73fQ2PBm7mJSXRzkuGU2UHV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i9cZk5rR; arc=fail smtp.client-ip=52.101.193.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAhIenqkGg+tOaV3nq4KjdUPMskP2yDGsUcL4GTypAKK0/s2wQ2PzTrW1uSslmJzsOYT9jZVEfWTj0NGcIt4sVZBglhiehkf2mjokaT3bpNfb/pmR1hMQSSgvf5awoDmSy/wJC5RLuBEZVuFvyigqSsyXmB47UKNiv2HRAws5HVv8k2Gdx+DNKD29S/t26adgl3AjglAmSrTbetrzUQ7O3WrGOIItLO4RXYR9oc9BF8bcJuoo9KGE8nnmMgWuiXqwkyWcGtIN+sR0bhvCU89HEPbq5xXO9Xcaw31zJDn7Ka3GLRJ299sOHE7sJw2qjZaRN2eXz4d2OUEjTQg5oRo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwCtOLG9+jM4lGxSvrTYzcFSiU0tEOn1dJQ8lXiwgew=;
 b=XoGv4WZPjELBLqcxr+QfO8jAVJG4DTlpmOaez8Z98N9lAYunh5wqrBbG/XUswea/YGMeLF5/1D1OJjTrOKglcW+2NFh6x6nL7BZe3P9mIwTR1XKIrGLGNhIIT30qAtjhCnoAQrJa5BL8be4pfwJi3LaCQ5FDvba6WuHKd4s2knvagF6qbEyk2PWEcVP5k3Xn+SAfpQzdwIo+nDfNsSJVIRzYFIrFMJjHno7baIrZx2I9hvKn/o8/fq2Bo9Y2+kvdvCppeGH01S+XxZc9d30wNSdwd1fpyZyKwHTnFxLTDlPnCKt+3jUSqHloWmevsQmeYbE5p16WUwuHgIALeLujmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwCtOLG9+jM4lGxSvrTYzcFSiU0tEOn1dJQ8lXiwgew=;
 b=i9cZk5rRLaGB22wZV4pfN+F4kA+PTs+kE8B2Gbu3aUJ/+J+cWCsFnZ6s0VKmrhNOKtvby6Qp2ZocmOyFODaKuh3FTsYN/eyk8pkibh8AQF7uwpMlim0wWgplhxLpii/C+OX1qRsgqM7TuBLDL8NBLf+Qxr1ou0pyGMMFIn6n0ARVvu6HpPULihND3hk99FPWdcXWYdEcFT9qI4L7+UdxjlU1nmbBfL7vuQYRSwZ0dc8tu4Ryv5ig4PNS9uLA2Bd1zNp6Mp3AiQxfrDZvEfqfhAkHgDdnJOH0jXGIcwe+OpDcLOd7LCcJP9E3r7KCUs0Vgy+Xao0YdoXXI1hx70pEfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:51:06 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:51:05 +0000
Date: Wed, 6 May 2026 17:50:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH v1 net] ipmr: Call ipmr_fib_lookup() under RCU.
Message-ID: <20260506145055.GA704316@shredder>
References: <20260506065955.1695753-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506065955.1695753-1-kuniyu@google.com>
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a45fb29-4a67-463a-f694-08deab7ee66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rm1qIuI3NsL6TatYkTf/p7UxigNyekAmK28olSAh3Q+hh0Q8jBWxeUPWXKCtQRCI/JKBUHjtzJszj5ro6f0psF8msxmruLr7QHzQbiCNIM8EAgBHuAPtIJyHpptxHrC85cC5Wm5k8KdCd5osMcvLZy7e6sg7O1N7JqY0/rcJcte5qdFZTc+C9TvtpWyBC4Al/8sck+mF21oWLGVkd7WpQUEpLpljjUjuRBqM+FjFu+RnXMZiUy+REws7f9XVp02b3RF9gJ228xLscjwtwj++srbuQN7STQm3l6N58AIQebupUSWYPyc6qgfUMLQkXCsnXRazs7CyH5U5Eip8gxdw1o0du+h/BYeRVXC3Vy2esh89Ov5v3Xt2qza5Qn2ayS1rPhu5zOQobZOAGsL+AK60Ic0Yo5qOuRBpjFeJjrR13RQn/7w0luk/dU6IGf8G70vIloLUHvV9m12uifYjE0esFJ4hKnPSPT0Nvh066kb5D8Sgln7MotUwHOF/ltcjmPDou1hTKX/8l5uyGvafJTumapJl512uimurWLOn+BSv5odt+2Cf9nN1yQnJl1JXKSa2aqMGMa9xSiMz7+4TBKu8SCVx8hrvoaWwJjYm2l7p31/VAy8425xw4srPGESfA3/S/eIz8I3E4uqlWu3TB8uXv4uWClQSRd26Ru+WJtyxZ8KSKDTHVSUGBVDfwC2Du+44IdoLE9co4M5qw13d3Sd5Eg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?crqPVSEuurjnPUCnwf0Gj6K2gyLOOXnl+ExnYn0NOaYyoF9gLVxx3MifOi+w?=
 =?us-ascii?Q?HmRcGGk5h88TUKkART76WkL2DdT8D3ACm3nF57DdNwDnM6m1q77zQmw9tHf0?=
 =?us-ascii?Q?myTtDvTxXkpyrD+oDkG8uC/gNRQ3Ed4ig0127Tqt7nkNO7p6BGzHKz+zfsoK?=
 =?us-ascii?Q?q/GusSXntvTinBYUM0DRkE3AIFZDkAY4AiypP1J5e/5k5MJm4ysuafTHomwP?=
 =?us-ascii?Q?gj2hTAmq9k9fY9ZPc2MkzNSf9/ORsTMOq5J8OZFGALNROrGvTIRcErP4ixby?=
 =?us-ascii?Q?WmFgj5FQpv0ZhmsXYETqTc+TO7cH1NgEM7ZSotyvsVZ2VVDpqfYDZXiudd6O?=
 =?us-ascii?Q?OwAfSUIoCyL2vYJFwrBWqMRMNm/QrcCzLmRU/VZdhTRn82AMY8SMAF3Gk1uG?=
 =?us-ascii?Q?8j1kVcstGFjjk14hDQujeTSZiswoQ5MGSnQq3iPuub6PWomyPC3w6uobWwsy?=
 =?us-ascii?Q?5cgcbjfudi9BVQX7x3ZcFsPZLFhfEPRu7ze8Kmt30z19YS1WkcW5Df4/qxoU?=
 =?us-ascii?Q?tdfhqeK0ZJ81T6RRfUmj3FcrAUJahgSCVy5ufXa7sXbNjOAiKSnplrJEnBPi?=
 =?us-ascii?Q?DHm7gFA4RYKr4W19YSWGpgH+iSuQbakUpP53xKvidl+v88xHn/prw4I9d/Q9?=
 =?us-ascii?Q?YuC3ohS1rq2TqSq0LJwOQhyMrCskKkf2BAi8Vx2Y6tOrzCj73lrm8Cmz2Fkb?=
 =?us-ascii?Q?FfCIWxEYKuX3ivjuxblftGvunHMK4sSBy4uXfexfCj1HmaezEnEZPwAypWo5?=
 =?us-ascii?Q?4C/nU/OSsV1vx7KhFwRfETfj4TOQLZdUkT0zrjafCWggMTfH3dhOQa3kPQhk?=
 =?us-ascii?Q?ngjFiDvudhGccYDQSIvGUjuRDa+VuTHeb0Suc9Ox4VBoPqzXz3KnEv9WuI23?=
 =?us-ascii?Q?U7lly65VOCulO2zF4MH4xircRX1dWSZjy3kIliHtE5TrkJPdpwiY0tf15gVS?=
 =?us-ascii?Q?PQnqNCb7SOkuTkJyf9f7sgkIOsx7gSUqThtFPQpHenALyd+M5szrtegvRCgM?=
 =?us-ascii?Q?q41Nls4twqvZieKK5T+4t1OPCot78Tkaso8I4n028OjM/QTM8YHzRONnQudK?=
 =?us-ascii?Q?87G17P6EjljVSnyL+VcIw2UxmzjaVrlh3YuS6rWFSwJXNUBTNud7d2ioX/SK?=
 =?us-ascii?Q?jVgkoZcJnbaDR6EmNbx33Y4MIGHT1ovNt0yyEB+cN3CYr7zdg4xZW0ShaVMn?=
 =?us-ascii?Q?3PHU5NUdzmtcM9DqeAQLIfTIGPUH63Nt4qqjGgaA4E9i6ip2MgaFDreT0oo9?=
 =?us-ascii?Q?c0KjDyta9Ffkcffh1WHJ5FAUZhSL5ZAJiDsCdS+YdxUfCAvxfoG1xdghE05Q?=
 =?us-ascii?Q?bmo5jjMZEvfELO5ofQgfeTlSOWx6jXqjODC6xQS7YHwSoJjyAqVnFzhEZjdn?=
 =?us-ascii?Q?JMXuclPp+dVia4Umpbw8arU7lbCvsaBlVkUNw2Mwxc2xAGCw+G829XcTElMv?=
 =?us-ascii?Q?MuvNH0smYoliMXRl/uTH3vgkeEEfLdUSHEyD4KNxI/Oci76+S2cQmqtwAiTp?=
 =?us-ascii?Q?ry5BNJAF+OQ04DJ2V6tKJcRUfcJ4r5QFpXqRFqVXNccB1aUQvKgynj8CW514?=
 =?us-ascii?Q?q4DkwdqnfEe33rgYTzuJSrne8JWaBVW/gkBJh/YrqJGt1Fmc5TC//3nk+ONa?=
 =?us-ascii?Q?mvOe3shy7s0ugQSBW2Yw35Xg/wggu6AvkihHD91TME6yeYjOCwpqvzn3KEaM?=
 =?us-ascii?Q?EUaLB2ouEkb58eDqNf4HkuZmEOSMgRUhiuD6fYmq3Y1SNcbD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a45fb29-4a67-463a-f694-08deab7ee66c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:51:05.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oq5N/F7nVD5rVOGeqBJujmrXSZptjFPPG6h4hn1KCU8D0sOikdfu4qVXxyg63HpJtxVbpcU8PQVWbfYzc3ubQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
X-Rspamd-Queue-Id: DB1B04DCA65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org,googlegroups.com,intel.com];
	TAGGED_FROM(0.00)[bounces-284895-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlegroups.com:email,intel.com:email]

On Wed, May 06, 2026 at 06:59:53AM +0000, Kuniyuki Iwashima wrote:
> Yi Lai reported RCU splat in reg_vif_xmit() below. [0]
> 
> When CONFIG_IP_MROUTE_MULTIPLE_TABLES=n, ipmr_fib_lookup()
> uses rcu_dereference() without explicit rcu_read_lock().
> 
> Although rcu_read_lock_bh() is already held by the caller
> __dev_queue_xmit(), lockdep requires explicit rcu_read_lock()
> for rcu_dereference().
> 
> Let's move up rcu_read_lock() in reg_vif_xmit() to
> cover ipmr_fib_lookup().

[...]

> Fixes: b3b6babf4751 ("ipmr: Free mr_table after RCU grace period.")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Closes: https://lore.kernel.org/netdev/afrY34dLXNUboevf@ly-workstation/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

