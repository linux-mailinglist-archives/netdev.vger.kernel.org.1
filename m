Return-Path: <netdev+bounces-281800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMC9HnyW8GmrVQEAu9opvQ
	(envelope-from <netdev+bounces-281800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:14:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C66648371D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E874305DB8F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB173F23AE;
	Tue, 28 Apr 2026 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SUYrFEm7"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CFF3F20FE;
	Tue, 28 Apr 2026 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374451; cv=fail; b=jISq9P5NlqkJlBQt0lJFIXDt1ESEic2u9Rqj2xakIbMBd7+9H+LTWdcbSHW53pWB4vTUwOMqxBF/UO3W6CT+ggqMj8N4u0B7uKVJE18l3jDEThA8knPKL8s0eyuNpO7LkTyMEAwqu2274KfUX0cI2O61iYtHmiIqp6xeFRyEQ3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374451; c=relaxed/simple;
	bh=t5KoRqan7PxVMk48X6iPr7edWi9lSJyShr+hMcKTJtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tL82yCTWH7zi9m1Fu5hS7CPe9eExB664ATfOE2JUWrkqzVk7IvLmXQwNcWbNWEusXHbPkRLSTcuG60HuNxmHTAcsrgMu93Dysm32aCfuYCbwG/2ojn3QeAqYLv5V8cBbpzeMsWrBL0xLHBRAPB99e+5WnnCBKHb3/QyS+aB6Rek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SUYrFEm7; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JosvVneqgjtd1BCyYC2781Tc1eqToQXV3CP1Pu/sKzLJRY+Jsay/wXAzLo3dSCYKz4OWVegpzDoWDcGTR+Zv8XUjYNJbd2Dl+5ureebAzHylEqsXPKORVCBRLE2s7Mfup5moaVmxSWlWUyO0fMYiBfWj6W5/c6B5pbWIfNFE9v9aZxacN2ixnFWL1rUsrXNF2rm1AHGwKkIIjX/PlbDbx/V2pASkpIy+Fz3JjvTlC7aErfvoOXvQoYZybwHnlVvOUyeKI0TrsDyH3D4fha2uUL52U0dMJZ1Bwm/Luql4HZXwW56oh4l5aTyoTGq0vID+fx6f8fNzNy+HBJMMX1dq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmNFJxkDGWO19HZfq6c0HYdYud0wq2SWNKbBEi7oUoU=;
 b=BqDLmO98UvE132kueXybG8rCOvyEs2fUQDEKtoXi6ykQ6/iljlrEpVIqyYy2hAA8KxQJopi1SHFPtaJgr3pGRULtOZ7Ze2gaIODJRuf1V3kcp9/gA/vnQ8Gnb6VQqUiIgBUk969CRTcgmFsoVUOhrSPVnLYNgiwZ13ot3Ke36PpTOim5rQ5wH/xSlux+r1SB4PL8+2voSP9dNOlR232ZOIGOK7ozeUQAGQp+dCMI1C3fZOQ0KaaDHrT2CI8LiegUNEnHiTWAea84mUWHO5DVmP0eUeCERd2inOCDwHh8bXW5QrZCn0EIQ7ArhXUh9cENrC82i1+6K11MTHkjuyc0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmNFJxkDGWO19HZfq6c0HYdYud0wq2SWNKbBEi7oUoU=;
 b=SUYrFEm7Cn+YLXg+YMWrfgahUP0QxEsPtqhRWgxcwmMvG+XqQEaRcAdej9irxaUKNCStbpshrWy5jtg8uBcSI8CX2Ud+msZDB7VNeR82jnLtnTlQag+2plzUF350vFEl5VysaIeSY47M8YjJFs6vjr2+ZKYW1/nlfJnQX9X2helXtYiHxq0b9TgSJLB/KpO03w4gW9asHnR003yjcyNsKs0BmBiFhPSSLduEfT8xGTnKdqDDYk/aR21caKwzRJ8oaD94rpBQrJCy7gToQ6Fze6uRAkoRJ7JwDfnUzg2J0S9bZSjzckwapwx6sOG6DOt7LCBy9LYd6t1+/pl1ZfwYag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 11:07:19 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 11:07:19 +0000
Date: Tue, 28 Apr 2026 14:07:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Sagarika Sharma <sharmasagarika@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] ipv6: update route serial number on
 NETDEV_CHANGE
Message-ID: <20260428110708.GA571865@shredder>
References: <20260427224243.3499162-1-sharmasagarika@google.com>
 <20260427224243.3499162-2-sharmasagarika@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427224243.3499162-2-sharmasagarika@google.com>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: eb840a5f-2938-48f9-59dd-08dea516506b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XLVSq2pI5HTUXBbK1siJkDx66ZChFUhglWTzAF7goHd3+JIKBrRk991eiUk++JTU5BpC5CqjtYUdtDuqP3mEIPxroM6m6qHvzA1OVK2+tQ5Uru9SQUtJaTtTcvdQruuwSWovYTxKTS0Cp64J8yLeLvkVb3yqwwKKf8FpDZlm7eZHt4ZN3v8ch6LaL0yddPZhaJZYxdUOqMkOWsNJpsoguqHaVY49vP0pFnEECsQSoBI3dinVrxzT3VIwKXjI47gue/UPdCDyGk0f363BRAFbj4a6wIQvkVVkpXkOy8lk9OBg1IKEpr/JmHxzxtIypR+scOV9Pminbv+UwIkVBuUqVonLAV7TCZoFSkBtejL0DpecZy3OB7owZUqLKGVBaYiWCJ3c5MuSWaCJK1+/JLxE2ldVrXMeg+VBs0BwQl9TYIDWtlRbqtfgpgfiP8q4LDffJCrb8VHR80uYSVo4K65pyaBDZiQCcLsQMSXdbEE546h54Hzhl53Auomh2ZquhL/vh4ZhZ1fHlJPJiYcQnVbJdSSc4GrDl/NnLjxvTj+O6mMW8RiO/oCLQ2Pz1YdzPszjj5uK0YE0yDaFy+w5eMN8oQXX7mrv9xs7MPN4bIfaA4aqWxUCcaE2ed7pnUXhDPVUB5Vv+gIvRWxarzNEtdc23h1jieM05s64bvhIum615CxloG9v33BdBJnGhWTRmRpaUWjRb5XtvV4ZzmwNeuTAUBxIDI/L7nqLOLs1Wv7QNSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ccyVepLOxA3bvH1IXVk6T7a5ytGMKIYQ5YJLJ29YBpTlJEH2XqgQhlhwqPuZ?=
 =?us-ascii?Q?dNfg8ktYOgyKS8Xw4zhpAojbDuA1zQyIH59XDtAjYPYMIIO5U//L+bNxqsoR?=
 =?us-ascii?Q?huyrx1kOa917K0QYXxzKU3RGm/q/mwF37GvHZMnr7GnA5+orpKQ/DGXTVLW9?=
 =?us-ascii?Q?KyEdKKihjDMEvp7SIzYjlI/ioKkVH68K6jyEmAdp9U2VTOPBoD+Kh1uzRZ9W?=
 =?us-ascii?Q?rv6baLpTsXwDoVSUgS/XyLhpIiiLSXvj2xMTYpp0T8sB3C5Y1PLLsU2T1Ro3?=
 =?us-ascii?Q?iTK8Io6HafePhQpV1K6foA6m1phKBmjAQoyFyZzGSDuarLxdZlb+09/Arz5c?=
 =?us-ascii?Q?7F1FvxeX+B+RugOUAC46yu/AbotaJeItvPKaUvn+jHIEKs4RD4UOgitjdeX5?=
 =?us-ascii?Q?5rCpVFr7fbpyLxBC5CMftuLUoedvJ0UyYpR/2Mn1cJCIUMGlVvl8JuZ9mLBL?=
 =?us-ascii?Q?NW7l/QwxaYmVnq5vgaNR0Y1xUq4d/fMVqog/kjO/GntXOItuOgw971zwbEGY?=
 =?us-ascii?Q?wyWlsvFY0nejKyrfn3Ij5UlyVOEX3afwKuLH2Omp5NfC092/5+tbFyvG2OTV?=
 =?us-ascii?Q?FQO5PIjwV2hrV2X3oqA+KiB/v9oTr5IHOoopfK3FNTHS2/vLb7Daiu8irxHh?=
 =?us-ascii?Q?2RQseN7aRDbBjFXRm7BtaDZk/5Cpz7dLxb4xNLtB9Wv6kV+D2XT9iyHaueeL?=
 =?us-ascii?Q?vqyL2+g4yn+hc4Bat9nx7cb0C9yvcs2Iu4q1+wS7zVvt8AgaONnvEALF3hLW?=
 =?us-ascii?Q?7AVWc9byi67s+uKFd0A1C8wuT65EO7pr4togXAtTxEqPETqnvxYhHxKeWKEy?=
 =?us-ascii?Q?8amqPRzrrWR+RdJ6NcO1gZ/LHZN85r7fha4ZaC5yXXYUd1QrhPGITjLjzFAn?=
 =?us-ascii?Q?H0YXYWUN/aB2WD02Ad4avMQgyCNT0oqeqvTcZA07+PPo60RO/HdRe998GBvW?=
 =?us-ascii?Q?sOsJB1WlrdkGfRd0XAVBACE5WQ96AsELiGwRr5nGlLFzRlT4CzSiRigPRqND?=
 =?us-ascii?Q?adysDNHjyyUrfkOXlhnUBainhpAxIAK+U5DhvjhD5krqhKlnWkp9PWXS2nAW?=
 =?us-ascii?Q?tqbRFtgPiJiXqceE3eajk/9dl1L4LvGFI8EL/h5QAJonjClA7x8j3YRHPzTN?=
 =?us-ascii?Q?APF1OJn8wm0YXvUsAReO5hQeAbqcTGv96mPkrhRKC+bYfzYyKLxrfW4TK3RW?=
 =?us-ascii?Q?rwPakAlAvAF59sPfZJXNW8sQsK4VjLrF/aNEOV7aGLuYGBxP5Go315+p5mzg?=
 =?us-ascii?Q?UnCE6z9ey7UY3IbEC6viIQwiiRXv3wtBUz+Cjz7mhlvF/oBpvzPvlpwh5PMM?=
 =?us-ascii?Q?TKyJc2VT6AmggjRvPxVzHhnIvQD0rx9loLvV93UjVlCY2NUwGNiCAMiUCwja?=
 =?us-ascii?Q?VbwXi2YwtSPWj15Y/rHto4dcWHfFuy/fYjP5NFh2Xqc1oxZDCVMbyUUD1UVv?=
 =?us-ascii?Q?EzEA6hkDvNXevNpdd0gIe4rMhWRAYRwe9cw0cLo8qKo49c97C4+gBB5gqNxK?=
 =?us-ascii?Q?hZ9dg6JofBGhFgZs0gS+cp28me1Z6yz4TUJvsRBNodszn85OzliCOzPME7I3?=
 =?us-ascii?Q?wMTaikOzZA7d41oTOK7DMbFAD+f7R17hc+N1b38XAoxyYzgJ5Ft8sWTMgP/o?=
 =?us-ascii?Q?wP7DQwa8MBOKW2AUbEatn//+Oj6IKE41JRbQAOpT/5Snu4sEzoYYWYlMi6Ay?=
 =?us-ascii?Q?HCnuPFV6mFnn+G1hbmOZ1n7BpdWz1iSAjG+TY6x26FPXDUaI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb840a5f-2938-48f9-59dd-08dea516506b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:07:19.2596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9soT0Br0HQqKhJ5XGI0m/638I/pjZdUexFoMNkd0tYLuCNM11TgNBKv0v3ZXAFDBg77JU3wEXlaK+b7utgsVYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471
X-Rspamd-Queue-Id: 0C66648371D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281800-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]

On Mon, Apr 27, 2026 at 10:42:22PM +0000, Sagarika Sharma wrote:
> When using IPv6 ECMP routes, if a netdev listed as a nexthop experiences
> a carrier change event (e.g., a bond device generating a NETDEV_CHANGE
> event after its slaves go linkdown), established connections utilizing
> that nexthop fail to fail over to other available nexthops. Instead,
> these connections stall or drop.
> 
> This happens because the IPv6 FIB code does not invalidate the socket's
> cached destination when a NETDEV_CHANGE event occurs. While
> fib6_ifdown() correctly marks the nexthop with RTNH_F_LINKDOWN, it
> leaves the route's serial number unchanged. As a result, sockets with a
> previously cached dst do not realize the route is no longer viable and
> continue to try using the non-functional nexthop.
> 
> This behavior contrasts with IPv4, which actively flushes cached
> destinations on a NETDEV_CHANGE event (see fib_netdev_event() in
> net/ipv4/fib_frontend.c).
> 
> Fix this by updating the route serial number in fib6_ifdown() when
> setting RTNH_F_LINKDOWN. This invalidates stale cached destinations,
> forcing sockets to perform a new route lookup and fail over to a
> functioning nexthop.
> 
> Fixes: 51ebd3181572 ("ipv6: add support of equal cost multipath (ECMP)")
> Signed-off-by: Sagarika Sharma <sharmasagarika@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

