Return-Path: <netdev+bounces-283648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JikFxWP92kEjAIAu9opvQ
	(envelope-from <netdev+bounces-283648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:08:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D23474B6EB2
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 20:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46B723006B00
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F864378831;
	Sun,  3 May 2026 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kB15FGm6"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD823E33D
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777831698; cv=fail; b=QiJOP7/L7vkPV7x2JwW1nJdhTOI8awv0CFH+pjKyPAJd9CzrbP+Ew/3k93kqqvi4KWoKEgY5/gyAwKXGpnUqsdNfdXPyUDoTdCqluOpvWHvpLW7gJ+wRYzVsQitb/ARl+qSXMqYYWMu2JAEOau2/IBBrzzeNYPii7724QR0gCYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777831698; c=relaxed/simple;
	bh=eJhRVwZ8/man1elCNw90064xRrfVb2xlrjN77eyP1BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FWoqZYjO3sBpDE1gCy1iDu0twoNQSDs+feDiMwp2EKJzJ3BQ5opUyoTDwWo1NxfnfiRsPXE84v1rDTpf+69q5HmBDw/JV3avB7shgQhzyMmx1dfAgsFMnxLj9PhYcF5+ejZri8AbBkpXR6WRZpvrWN8g64FiYan6/uZTTclpECE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kB15FGm6; arc=fail smtp.client-ip=52.101.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXGgoqzqFYc1QkRp5C4yjfSOZEuRdhZicMdOAIdYFyyvjBaWg2EHfGbi8gDwH8ujl1w8rpusqc825k0cdhvPSCu1V45mbRcOzQOykBH3H9GYlGgQxrkMmyZCECOJOQBsqgH66OEBRWxCcCCpOTsL9fgD+kYbSmtOj5wzDfTXOhEcMgFn/vD27MQo2wlhKcTnszP53OWXkF7vs4RzdXRv+giIU18wUK9PfRKD0kQXtfd4SU8mw3RvX6nte6r78lQzP/97lfmQyxsqrjN0W8G8K9PdHLpr18eI7LOoRxBk9WGZpo1Go7KRAtLbBW3l7v4sp6apQDNYYSX3Lz84PetQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYVw/ba39RraX7K9IIMI1N5pjHXr8gkiKq3njq9Su14=;
 b=dMdF5qahNNIguECaMkGkOAky08f/zF8xiwqx8Fy/gYPXez9t8P4FYiagOznoMxaskrhpMkUhuLPJ/mI6FknMJigxTl66yfYNDgAuPwKITXjhk6kaYYmlbKuUnLpsHc26v9hlNq4Z/sL3/FrouZy8LPMVgtPvedk5DL6Qopr3QgHjR3p2LPwk7Btg3b1oLK+LPILG1iw8a0DNlVAx9lnpcDLQYKB9Mnz5HNwkX/m+pLPBYKySlok64YhejtYXKlRaX66NNgVFNvS83acQAFfjYb1kg5dmCOwtocmGy0x6vcVStkfqVPwWEu+xfJWmQOOUBvyCKGsYvskDSB9t2NZevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYVw/ba39RraX7K9IIMI1N5pjHXr8gkiKq3njq9Su14=;
 b=kB15FGm6TZ3f1AdkaS6aiNj2bpCw5fH7xTrMFwv+MI3DxIUUdCb23cWKSMyfJQtjhzIRFI0uzWEtiCfWjv2AKlXMagVzWpR7fjin0lg0vrZGj+X8RjwIeaIYrQ4b8l7a9U0aBWoa6WZTdYyVxhsp8jl9a/HXtCnx2tUR/ThwA4f+MNrHzsymW8JCYUilVXVcIw2cWepfBG0ifVh4DXE5FP7gPZqKVMMmhxqLLFobTO2JGpQAXWkld5e5B7nrgqeQZPnUA+pNamZgslCqspNir65xeYX6Knzyyj57WXj9BkjdgDPRu2mDh+Siex+H3pHusDPhF+9vWMxuMTTZXiwDmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BN7PPF683A477A9.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Sun, 3 May
 2026 18:08:13 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.023; Sun, 3 May 2026
 18:08:13 +0000
Date: Sun, 3 May 2026 21:08:03 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
	petrm@nvidia.com
Subject: Re: [PATCH net-next 1/3] net: Do not unconditionally turn on carrier
 when clearing protodown
Message-ID: <20260503180803.GA269092@shredder>
References: <20260429124624.835335-1-idosch@nvidia.com>
 <20260429124624.835335-2-idosch@nvidia.com>
 <20260501180843.069635aa@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501180843.069635aa@kernel.org>
X-ClientProxiedBy: FR4P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BN7PPF683A477A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 2193557f-5252-4dc3-2add-08dea93ef0f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TYVoQB2TraAtCj/xDo6fIB2dmd0Y4jDUUC/rxfhy6V0ZCbQ6O6TLZ55VBCCSb4/0H5crIfawXn9AA/1wit5Ie230fXDMoFR94kDfisgniXjHwGqsf9AfhBqnb9vz7zFBarbwZagOhsTvePpDe31hgMx9CVSJ1SjryGxBBVv+PlL9BbZUv/oRk7CKizvZimRpjoQTy3rRm9gnL/FugsvsF3g6Cn9n+oa+bLqUg+DWkRAoIO2THnM8ExVci1Cor4x9D5gq5JeXigsWPHNOtf+KFrnhdR339ojNbUzlMibV60l1mhJZ4a5PAu9i5/ykLhVGlpqXquwI42SMPrUW2uUDh0/JnWEDJkqelJvQQWHAK3HmoKDdBcm4IXoEYBNYEHFIeK1rFkZYpna1Iv98Lbcmk+uzVAzywTrxR/yV1NEzhuBxX+kf6vPTszTQ9Nrpz8wIAuUm2sj+L0KOlneiK/Btakma/0XIUp6HlB3j//SEfWG+O9Fy4P0kx50PqMtKj5W32Uhcf5MV/W1c9NajnysqhapBU25YQoPgf0fhN8zpV2mHsKWRJNWCXVVEQdZHB9r0BH7azb7tfh4rtoUBg+KF+/31xjPokW54s5qPANKNzEoL+be2pNuix3SDZ/gOsKsbzEBfhzLT36Z4GrUhxMNGOSgO8tD2QekvkQuZWKcGLvlYtOE4qBrbRrFSEjs3bewGrwJ29KbrD+8r1rtPEOuZtA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1BGTVtCPSP+WY2x6rj5ptUXFFbKV38EKu7rXxc1gTK6z/LzYF3b9QqieOJoe?=
 =?us-ascii?Q?Nr7s6CbD+2Kv8s0veKFT5wnXAukKn8j/SkQawhLZN3jNz3hIKLVBXXWbQ7I/?=
 =?us-ascii?Q?C9dneknksnfie7ygBq7CzoPn8y82QIokJ//oVqZd30va6aS4GyIP5joAZCHZ?=
 =?us-ascii?Q?T2btfFHdCHZZ+jYxnq3pwnKoK4mPi+oZCC02ltk5UeCCTeo1B/sUbX8Ld6TN?=
 =?us-ascii?Q?rLFHX0ilafRhZdnR5FrEZGVzAlas4RKzOU02jbOkmhQchz7BbXvt7GgWwe4Y?=
 =?us-ascii?Q?jO+huQ9Lj5z6qljK1fRQAUf8MlsaT264ASvBYadCkFeDOSsTWH5k+sUquUZ8?=
 =?us-ascii?Q?iMdowiGLxkYjUVlN+KnEQXzhKDzKOoZLUYIR0akRQ37MbH3MTXbAJ13IOygs?=
 =?us-ascii?Q?tpwzFDUvxrAZpe3Cc0cg8QX/fS1ZHUepU/DxcnmHKZdN9GRk2qRoB4AiWEwH?=
 =?us-ascii?Q?grtiVrVRg4NR4yN2GNnkiqLzyfRuPpclnjvoq4yKu/NmSnofkYRKJ87Vzr/E?=
 =?us-ascii?Q?LrlEUd4YAyoNewzYzVD9eLNq1JfvJKMXIVsk/6haKay5Ip51rNViq6046ub/?=
 =?us-ascii?Q?EEKR+qs7wUxhwEOYDpP4U448QyqJLUbvZ7TWVJmiiVAy8eFVWZrkkgU+Ufvp?=
 =?us-ascii?Q?JTBHRlG8os40nnrzLOc0SjmukHw+w+KlAuu5cCANZAaN5ECnxiw8MTURVW5p?=
 =?us-ascii?Q?GjCJMFHOoDSywEHxog+NAEZggWN8IsUS94OQ4YOnom+QUcXXszwuPv85zYji?=
 =?us-ascii?Q?gqzq9zGI/w+la+ra4VG+6aee6YP1TLAU0o1w9nJqnTm6OkQY+K4n3TcIowqu?=
 =?us-ascii?Q?dYT4qFvhdFsNEpj1oqDFYU2wTdf9Z+LCyX0cLY1OAL3GmqAqmh4Zgw9Tfc+d?=
 =?us-ascii?Q?bg827tF9abm3dv1duTTey1HhVaVwcnrA+o7Shtmq/PoNZawIyb7inloobieW?=
 =?us-ascii?Q?wAl1Ggry5jDjpo7lIQM8TJBM3icSDb69ezyipGTvjChVxgffi7oYUTEdTvzc?=
 =?us-ascii?Q?6LeUIJc5H7Wpr5WqZEn6GfwiWIt4dO030YS8JQjObRQfqXCTKKr6FguHwQhi?=
 =?us-ascii?Q?KZXYXTEnljIlpCBWCb+O3a52VJeSIiJEudcZd4N3lWwT6R/Uk208syDQ7Jon?=
 =?us-ascii?Q?QQGWg8L/ajWvpn6PGEVCpeKq9XjmjMVrzhAClcHd69FYxcSI4MMin0LV+ghQ?=
 =?us-ascii?Q?kS9YhYS+knc3WIwdxUgVeYGKV4H8yJPyiEdoWwvzEAEZi8OkTzUyF6MQGvSZ?=
 =?us-ascii?Q?eftym0TpO+9kJEt0csZYggi42IhcvxriHU3v2xlT8a0QAsdF1Zz6c6ssfkwY?=
 =?us-ascii?Q?ZsLFXduP4dJtR9dpzqYSdvtaW0ppTAucFlJ4c27BuA/yUzlqRIKBrUiGSW+i?=
 =?us-ascii?Q?AsItPRknLhw1STYT+qUFxlatLMH3Z0b2UcORx8SN7+qUjRx+NjzSeUZG0pdp?=
 =?us-ascii?Q?2LSdF1VWJIqzOTo1U0cr+b2XVvuRItzDABeBKV8EaFVLm3MVw/QekQzRdHXj?=
 =?us-ascii?Q?pbs/f/RfXT7hczIMI/R1CTt2CQV9qBk7AOjpo1W/+1ZB3dvP2MUEVH4GwbVF?=
 =?us-ascii?Q?J3G8q+ZW08ADMe931gsmqWyULQJINccZdkfVbkUjJWuUWnOTgqGrWzJXqKt9?=
 =?us-ascii?Q?APZEhQBUzipEw6QV40dQIhYPYH2oPXU2rEuyHFLcEW8g2H1fnJfe1cZ0gMel?=
 =?us-ascii?Q?aXkJwUE60np+699SWqhw9gTz780567XTxBrDc+1x3skBLIaY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2193557f-5252-4dc3-2add-08dea93ef0f3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 18:08:13.1161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlpIfoKE0Xxy/bSNBrek96oFJfw9F0tAWQd/g5SdnlDTL2fTEPEb4lx0xbCSyxtmRUAdbTN2vCy9n4faPeNY9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF683A477A9
X-Rspamd-Queue-Id: D23474B6EB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283648-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]

On Fri, May 01, 2026 at 06:08:43PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Apr 2026 15:46:22 +0300 Ido Schimmel wrote:
> > Solve this by adding a new NDO that allows different drivers to react
> > differently to protodown being cleared. Change the core to invoke the
> > NDO and implement it for vxlan and macvlan. Maintain the current
> > behavior for the former, but for macvlan implement the NDO by
> > transferring the operational state from its lower device.
> 
> Maybe just me but an NDO for this seems like an overkill.
> Isn't our range of options for the callback either follow
> lower or carrier on? Do you expect more complex logic?

Thanks for reviewing. I don't expect more complex logic, but resolving
the linked device via the driver is more straightforward (unless I'm
missing something).

There are drivers that only implement ndo_get_iflink(), but don't
implement get_link_net(), so it's unclear in which netns we need to look
up the device using the ifindex we got from ndo_get_iflink(). Netdevsim
is one example. There are also some drivers that only implement
get_link_net() such as vxlan.

The popular drivers such as vlan, macvlan and veth obviously implement
both.

I added a helper [1] that resolves the linked device if these operations
are present and otherwise returns the device itself. Similar to
dev_get_iflink() which only gives us the ifindex.

Another option is to add a new NDO that gives us a pointer to the linked
device.

[1] https://github.com/idosch/linux/commit/34c57bceb1a7e52da0f973914f8a4dd08b7f9072.patch

