Return-Path: <netdev+bounces-262559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YODRFRhMpWmt8AUAu9opvQ
	(envelope-from <netdev+bounces-262559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 09:36:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE511D4B34
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 09:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6826D300BEA1
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 08:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9748F389DE3;
	Mon,  2 Mar 2026 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C2aEAjNq"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12338552C;
	Mon,  2 Mar 2026 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440576; cv=fail; b=srVdEB3UCvDg7TeH6OkRryFy8AB3WuFoWRJCiZCRfi2ZHy3Bf/M3Y3ezOieBT7/Mseh5dibEtlcyugGWQiOwerMrnpH0rUFxMixBMhlH7zgWkpT3TT9nIX4J/Jw33e/ToeHiazFT3920msEZbN5Os7dTV+0SHv/BYv9Sr4+eJkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440576; c=relaxed/simple;
	bh=YhzKeHNhNWwOAHOclyLJRdAlvvazMzGj0lSEliXZVKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q8cRtV8D8lS7Dr5ovKSQtn2P3OOTJ+RvN4mYGn15K0Hqs9Qvmf7hCfilnThoVvXjh3InYHmVJcKjUhwJQGQRlfYXyRPWViIJITb90I8cT8PAdrUbBQP1/SljFDGP/dwzXZh8HZO6KQ98TGRgnLcS2fb4Wub0nNzs8RHjM08kEHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C2aEAjNq; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clOBF8UW+l29wvxeMP6Ql3O+NfUkTF+DA+GMnHQNoB9Al9eTzB0mSDbLBA7jPVQq6DLwgXADhU1v/2zb3HMelAU1U11J8yIbwlkndTr6MMMo6Bv/+ygQbQnMrunM3qd9FOHcWEXa1w53BH7UKouCYId42pfCJdqPfmECyse3Rjjg7/JjelgLe7LeCxjR1lHIomXUATluc+YFPsZcpxoKfTtb5BXfd1nGIjMr+tQVhNkJ+cnv1GTP1l4YqrlwI9SDfGRaYMnDnyBQAc9D7s51Bg4aNv58KxPlbn4Y8EjWrMWW70arKfA1xYi7hJpU2bTDEuDCp7ppZtJiKE52IY5T+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTNar71T8+hAq0iu9g6GohxypmqFRcxiJFPfz3/S0y8=;
 b=ibJv5KNt85fdmi7P8G+nbuLt3q9lhKfm0V4V1f6CAXOq4dheYw6Yf/RUpU56qi/XDJRzye0JKYlMfPbwM6pEdtWJk4fQB1ksPFVcp+rK9KYIxlQWk+DAQqQ3Xw0WqL/pw5UyLxzR8oZF1rJgUzPTODuIy6GrxUFZ2Eeb597ptKBTQgN5FE6dC/ZfV33iBJw01NShztShzJ0LZb2GUeVuuqe8bZe7XFnixSCf6yxJmCDy7BHivsFZv6AyQQqp8MgdIdJLkq6yB41LcmB74XWZeTmDgBUYGXJG9P95vpjmYo7mDrty3Qb7cCWO2LwpjqKSz8QjWnld6fqM4o1fseI5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTNar71T8+hAq0iu9g6GohxypmqFRcxiJFPfz3/S0y8=;
 b=C2aEAjNqpHEmbMU+QLho0rmEppazhu3/JEgPaxlUXda7PXZ7rTpnKHKnTXcXJj+x12cKtlZONW6cqNBkvTQymj0sGd+e7OcDWVUtNS1YqGSu/s2lxEZ2Xpy/TK9ekXjDORhYjd/oXcfUyH4G6z7GREXCgUpANl0IFPOgSfNSFvsmkdl/fdyCy/u2pcByhhLPSmRbGn6rF0gyapTlfAC3eEIsjUTOmVSlPXDqroqSNcjRLO70jPuSQK1s5YlgjeySXNsH3DgIwDPs0TKUsQVGjzIjecaltSzzntnkHoSMHt7pWiZA5L1Lq4QaKVxoHC4Uceq/+5dHi7+skJhBLZVY1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Mon, 2 Mar
 2026 08:36:09 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 08:36:09 +0000
Date: Mon, 2 Mar 2026 10:35:58 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, jiayuan.chen@shopee.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] selftests: net: add test for IPv4 route with
 loopback IPv6 nexthop
Message-ID: <20260302083558.GB814377@shredder>
References: <20260302051132.66314-1-jiayuan.chen@linux.dev>
 <20260302051132.66314-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302051132.66314-3-jiayuan.chen@linux.dev>
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 11baca6e-e499-436e-9d47-08de7836c104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	jZC9xs3PG40LREN4jBm7/idaxhcu/5xhgRZXJU5wSjx+stxfam5lLXhA/Tfp8QY49KegDw5dQs3J3hBOf/FBP6zdw1goC6yYNuvEsk9IDVNt5I7JQCrBDudJXs3raxzysOfBfGHXxbjLowkfDJZP0VMi7LUY22DJetpTV/Cbo7+2X0MKEYtTuJJNxSnBVGKrajpnHYe9tRFAwZt8v5OcsgZWWVGclkOi0aBwNUjNPHI6SAYmKzRqXTAy7airqCmLMW9bGFubNt1PvJfnTsxm+enbVHxN3dTTA8wDxhbw65oZ+8ER+6e9AKsHz4ipxXXJ1S/PBUhuQ18/i7XWevkWLzaRj/z6ktbBKRXM4azE+UP0KTH14fGIfIbHZSuPPH5nQ0Txv3k9lHIg81HFV6qCBT6hYF54P8KR5RZuH1tWRYgJOgSXTsYqSpmGSty0CkdtiZ2WlDgVd2ptjhY53BXkCgYrVjoyL++ugkeESAp4kVB0YWhYMXpY5a4Md3b2aKkQ2jgd+Vz1kB5lKfvOglRW8mjczkI4bbhUxyrlaFZ136/uoTzX4Z80BK7+HItc9+Ixedh+k8ajKhtdDQglmu0vg9wiu5hpOCldapbudGiIPLI78yPvr4XuX7356TFFBQ0xXaWGnsKtvPTV6SUWt0QIm4KHA3XOReK93c9tjcpTa8kTgDnErGmMZiq16LDt5s6BHbcTRDRQLm4WeFRZ86gbnkQc0q4lza65ILG01IsHL4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ws/bJdayc4g+TiAaLU7zkAaawvIBYfKW0u3GphRo9bnq58ty6AbQa8ZtBu4j?=
 =?us-ascii?Q?M9ws79yJwAlLhFknmNQfaq5QTd5v3+/SSrFHoqOaQUr+jj5kSKFpcQ6ft6K6?=
 =?us-ascii?Q?tpYBAvLMr3a3vsJVFloIU2mVGZ6QmNa5lKQwi9QZCNO/OwolnD9miMx0mwoO?=
 =?us-ascii?Q?D+CvkFXSFXtEKZKry1Jy8QVEyQrBWmAlZs1mIkFw+JIxbhOB6F/7vjvnGcAk?=
 =?us-ascii?Q?2fVkV0HpbBaww6SvUP5fj0vQ44selYljZptw2YX/wlkt7Dfggvz787E/QI5o?=
 =?us-ascii?Q?kcplsMUQFc0Jw64XXHAuYhCcRKKS5Db8h7lV3ATOvau4IXepuTSytyBw3Y4y?=
 =?us-ascii?Q?WtHN9G3qrcSlKxdwOOUfptrP6mM2RAaaary7+Xm9+69qaaiHm1tmkxTg5XDz?=
 =?us-ascii?Q?lBttPyyxh3O1X7TdNWvMK3Xh0fnbjDOUe2xLvxVkJCu52KA/Z6rrhCmSMtt/?=
 =?us-ascii?Q?WSSQEK//+v8H7sc3YvaI2J7WIHmC0oh3pUQkOh3Dqmfp0tVSulz01lAAotTv?=
 =?us-ascii?Q?dav3oJKBZMGO/mqFfGBTlsLNQ3o107d3xsMVfVkjsx3eIaE898uI7LG/Komq?=
 =?us-ascii?Q?REq8eXU2+VxCC1GpgNQO8RxdSr8BC4OBqziwTjEidJ4OIqiBMa5n2YTWRSf8?=
 =?us-ascii?Q?zGzG1b1HeoC2Jf9PHaCfGghMLcL6hsUPLDQsE9ZMOsg3Wuv94PYI28DEoj1F?=
 =?us-ascii?Q?aLLaoJifZb7pOmdLeOzax2tlJQN03CkxubBh/O8z8c9n03B/EyQlbWK001C+?=
 =?us-ascii?Q?8C8h4fq4Css8xjyi0KUUVsLe0Etun7x1ZaPz9wHEQwYIPv03t39Hf8wrY9wn?=
 =?us-ascii?Q?AC0Td3Mu7h2eejsFzxTBbZdar+uZAsbXFKr74x+E+4RrwPTQcfw9OK0z1iqL?=
 =?us-ascii?Q?mJEbhxymOoEe99hrmZ/1oo8aF7dxH9kxKDuyVde0CuSd3TBlb4q0r3HxV8XY?=
 =?us-ascii?Q?gC+x7Thu/PZWk+VB8I9KiHUD4UBcXavl7JtK2FCJM6UDFP0wFIGuDJO0w3/x?=
 =?us-ascii?Q?iN3nfhmZ8a9DVwcfoThAOVDC6aj1XA95FlMfXoEFBjnLBi1vPyyqPRYACc56?=
 =?us-ascii?Q?brDs9R0jM9l9heL0qOXHBm6C57coQikbIjgLX+td9exkaQQKGZtsJTPiJ/Kw?=
 =?us-ascii?Q?4kfRllJBqzkk1rk1TyRbSiYYwWyN3uYAwkf4hYyA8BO3WCFSFQYlOJrDYnCV?=
 =?us-ascii?Q?vEWKeIumlTcwukQsc+vD3qEsiFQjfawmEu+Z56ekYZ1fXpoxiql6hBsNwtF2?=
 =?us-ascii?Q?mUmsimXkXnJHgObu0jiXNn6lYKKMLdDaITC8aDwZcDtAmdhu+k0gQxmH+1Yf?=
 =?us-ascii?Q?QJH3MV5W5AETE8Ajtk84b3jIVAwuOqnTiPZvaPzVypRc26djrch9XsMZI4UR?=
 =?us-ascii?Q?5uZ8BTP1agmnzOyTQ3FOCDUxk8GhMoxaMc5U1BlvYZz8aDX5Ps4LYFymEl2+?=
 =?us-ascii?Q?ICsnlIpRNL8dXlgpN+eyLXd1u/Ygnxvq1L9ZojHI1azEZKrt9m0cjmD6Jx0l?=
 =?us-ascii?Q?RbhBvTn79TnJEURUifno5pFhbkRIeM1fPDHORmcq61iIRYLIOAt8PcBsSXDo?=
 =?us-ascii?Q?l+eQpFvrBr4VlAYLW4jnc+36iwAJpUHksJy5LHvnKTsl8PFURy/9FOqmrd9x?=
 =?us-ascii?Q?lRvUrmVeyLcsmkG54l0JWorUgySHnFkljag5t4A5rgezDLbzoBbAVJyCdfYR?=
 =?us-ascii?Q?XxbiEXuCFS7cky3EYKj3zfcWfZlsHZ7mrPP5YWSHFRSnM9jPk0nVEO/pPojV?=
 =?us-ascii?Q?dGGDJl4WnA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11baca6e-e499-436e-9d47-08de7836c104
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 08:36:09.6244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELf1YgEV91bw3BeyRvH+tM+7HU2PGjdfoNOkAjouvdMLQEWQQRVrtAB6fYfiZYetF07FL14LUMqoK2kfO2lEew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262559-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 9AE511D4B34
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 01:11:29PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Add a regression test for a panic triggered when an IPv4 route
> references a loopback IPv6 nexthop object. Without the fix, this
> sequence causes a NULL pointer dereference in __mkroute_output()
> because nhc_pcpu_rth_output is not allocated for the nexthop.
> 
> ./fib_nexthops.sh
> Tests passed: 249
> Tests failed:   0
> Tests skipped:  2
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

