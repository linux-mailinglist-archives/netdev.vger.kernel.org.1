Return-Path: <netdev+bounces-296925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 53eZHL23J2ov1AIAu9opvQ
	(envelope-from <netdev+bounces-296925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 08:50:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6F865CF0D
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 08:50:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=pcDCpHos;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296925-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296925-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89AE8302DA0C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 06:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F423D3D45E6;
	Tue,  9 Jun 2026 06:46:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACFA384CCA
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 06:46:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987590; cv=fail; b=tRBh9/N23JwDsVhO4yTf38DaSakhGP59eyKaPjyNlXsq+mO9SoClH9ZrYJVE0EfZ/Juw2ipi7Z6lvE3v/3vLS4lEvMG5yA0r0ZDkGMcAoy5MD+hj794sGyOtjqk6Nga7SeuFFzCfExpCJ2GYZ0/5VPcWiR9eMuxV13Kng2Wwyyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987590; c=relaxed/simple;
	bh=AmgtYul/xjUExQyYysnu0GTsTML81+8KwYrOh1K6BPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ap8RsKYkQ2SEMIy2noUJFvCCiogdxV7bbXrFseGQg7EpAkLFzr0uusjoAPMN6jN4FqFUSUixChaWkM6KvjoGZuffugp9GnqUI496MektRgCiXsbJtjZ01+wCuNlu3xL7Zn6ZsvwLiri+Yjj/v5297MYrlgRFXX2W+XtboXSCgOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pcDCpHos; arc=fail smtp.client-ip=52.101.61.71
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Skve0nMHlcxHeHQe3bbpPBJNuQW7NPl9mxwMsl2DjxgaNfko1xUFjUfapG1/SINZEAab1I2B2LgkTaROWmQwVQoZN8QbCphKwO6hsoaObDANZMNjvEadk0HQHcdGTHdw/6b7V52Mp57nDuZklc/x/Uvr3Inw8vg1BAE+vi0iwJmXo9r91B64P2ngVZRCxHqvrUhOfhUeh+T1S6e2d8qbMij0TGVQGrE9phXsqpHn1jcfHRHG8+br2mhD8FvVA9U1aCB9nWhT42oGM+N+twPMhRcqQ+1EWIn/cQAXGAER5dXiYhZDjlki1eRBysHTPiKcX6xtHNSeUsr5HehL7sdVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgGefxo/z5+a4LX3o0WGcFzMSSKJivRs0Qn51TEIVhY=;
 b=ZT//WCGqK36NPY271hhReUB5DlkRSvqQQw9yrkpVLkjhmwYkwhBeaVTCzK7+hGDhnZqjDwkn4Gc2pnfgZp2yYY01DbqVNYx5aYz/SFMBl1qUywUqHSfH3OgIjekY7eMhJOUN76Udi5KvoJlfV1JVko8DsndIkhY6pBX8ObA5zAQPl0VTBHw5MFQOfrcVYVJ0mCtDe+BmVp6OpO7O1kALf75i/oq/vGNlUrtI5ux6IWaeKaCg+I2RY2ejMs7a1ZTHyRJS0hANv0aJ7MVq8L+/5Ov0NnoQehesniDv+Rl4zKUOq3rLLqaxyfglCB/P+gXl8yfYyAdVThJpPkDEE9EPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgGefxo/z5+a4LX3o0WGcFzMSSKJivRs0Qn51TEIVhY=;
 b=pcDCpHosts2pKO8lCvkfNKvpYs2aOWVjp0lh+cM7SG2NsgcOhWlrMIJjKHlv4Ai8D1Ic+QCzvo1K4SQEpcbQqR/PqrvVxvxkFnjnQ/FGyQahDD7ymjqQbcImwSgBW64nNg4cpg2zuZN2auj1buqvg3jaIKI3rCeq3OvzaerNzARQ7oKfvrFQSuZmfSGLV8/Uur1zUUEry4Fth9mZp5946ZTzUdyVsV5aDGVkpXelV9Gn9x51vckZOEO32ykxykih99/6l6omGm1hkKDysWf3vSJPryqthNCRStEczjiujg+1fVzKCG4tn21ATfQiUmJHebXpVUL1EcwUaM0mjJT3+g==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 06:46:23 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 06:46:23 +0000
Date: Tue, 9 Jun 2026 09:46:13 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, horms@kernel.org, bridge@lists.linux.dev,
	razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net v3] bridge: cfm: reject invalid CCM interval at
 configuration time
Message-ID: <20260609064613.GA652158@shredder>
References: <20260606215848.1951633-1-xmei5@asu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606215848.1951633-1-xmei5@asu.edu>
X-ClientProxiedBy: FR4P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 691cde8b-590d-4820-df0a-08dec5f2d215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vxzYPWMAjTt2xe54UkHJqAVwih84/ewP38ONYQLWvsBAUqy1kPLQJa1i7dLR3Ff+V8WihuXT+qC+nWopDmcOTAt1gP65mofQbORDTN8vmLF8eiWaXAD/RSFzkWrOHU+xvpGGUDXF/lv7oWznLTWuejwmCeHH+Ks/w2Wz473XubR35ihXyNm3F6eZg1PCHytu/Is587LQxNWWi+AEDSmlKYbl4ENcgA7PucKRtW1KLhfCnQ1/97TI53z5lQW0VhfYRJIU1YxqQ2OuWbd+b0S9YXrOqj7Xp1tGXLmbW0p8OmYUKV5GD1etYurIeSqpMj1nMQn+0cn0V2oo4M98KvnRh8oxcFS9ZKGfjEI1pF8SgFoTHaNDivi50IMYr63phKvN+4yKVOhbs6bJXI2X65paZY6L8yNaBLP8V5qx0qE7r4mdQWb3WL3e8lhldDxHqg/JtAXsiXjXC2YWH1xm8b1zAi5T0EyPjnrpuI/5Sy2TTcKBv0guLoRt76HnXolHMYVWYS9BXI3FQW25wN0o5vmgPGEOhNFyPlbR1igJdI4kcbubNgpztGKHCugH6dLqKrlJHKuEYPtRAeyY4qy0hd2pDImcyLOCJRLToPMUKHTgCj9zi+J8wJRcLSzV1uKzla0h5XMTcQJCZAAcvdxCeNA1ck/uwckVOvWRDX+oy9Gz/lLxFkc8y854BdLcPnxQuuhw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NMrmArQKsVrw/bZgHvc8wi+JGJeCkyAR3w2hrkuzUdGct7C1LeSYYqFHKlpE?=
 =?us-ascii?Q?OoCSrHjiM+UebWy/sGyCZahbjABNvIcXysyeA8YMuZXkJK12X3yC97QZumo6?=
 =?us-ascii?Q?Q7ZxfIajlqul5EL3ofw/Hnq4v1hiZ2ukV6nPJEfkF6CXkeGxoUvqWfA6RYLj?=
 =?us-ascii?Q?TLN6ha1d9PqZwa4+aOdUJUkm4R8JBHDpshZV9RBuKwxCWbf7ZJYG7j8jRvQO?=
 =?us-ascii?Q?o5wg31/x49ZxyvFTXj05ASCSReAJq8Mc1r0eHPR8WQhr9dIcK7j6yoSi8uB/?=
 =?us-ascii?Q?huzxe2DBvFGivJjzSNcwRxcbrnyzunQC1/aAzTTeeeAHPmaD25XNtenyM/Fj?=
 =?us-ascii?Q?y/wFpRMI/ByFxhrTghtwpX/n28Y6e8prgrxTFJZOzhXnfpFgxWwxAIDha+Dv?=
 =?us-ascii?Q?tzL7QOtP28jjjQVgGB/M4QMSet4YxRSXPNM6PV/sKxEw37R/wsR3txkUzim7?=
 =?us-ascii?Q?k28SGkngtp9bVSkNVhZsceuUC7UgDJaRhbsg5bCkBahgrZfYHtyPPbfBgNMP?=
 =?us-ascii?Q?TVq3KKoUBEoP43wij+VcMV3vuNTK6B7oy3SXxx5x48uPHKX8ds7XycWwO37G?=
 =?us-ascii?Q?ghCdcLTjqBh44+VaFu+mIrddAU9W3nZqHnjidyeWdi2ezCLA7xFVzKJk2HE3?=
 =?us-ascii?Q?WHdO//nHDxCgca58oNonWcGOFhveHPHnAB/W7uauO32NN0kjd4XcgAcQJ8j+?=
 =?us-ascii?Q?XU6PC3vn8obdxDTXRBPinH/5b3QmMZG7cqYALa0CX3Hg4d1PhgNNPb55vUHB?=
 =?us-ascii?Q?5sPUwpDa0A69yDqVXuNIF5dWDo7PkIjLUaYP8d9Jhu3N9l/VJOy2V7NpTZwP?=
 =?us-ascii?Q?ZBZrL82lpoKoBEGqkZv0svRwYBcdt7hNfrUNgNI4CiTTCD1e9uOtDhj3lGFw?=
 =?us-ascii?Q?wv4zeWpP6d1Ma6wo+rH62R629BVQl00mkeoaLO2uF+FfWWImehuH1Fkyzboo?=
 =?us-ascii?Q?Hd/UAeYb3T8EAo2mnsI1dBSg0GNZhWjxrgZQwXp0MKxeR1lgXuAvPZEvOA6e?=
 =?us-ascii?Q?ouhDBwMhxEhk97rSG2RaCvWM1/JG5OpV7pQ30HdWqg9EPCJYvSUV3A8dhlUM?=
 =?us-ascii?Q?DgpxA7YCgXeqTzosFiJt+VR+jWsTBtIqBRyr5bKzC/Fp95b/3sEfIs92CNL+?=
 =?us-ascii?Q?ijUq0hS+Rf0riy7ryWyoF3opFJflFXiSPGt0ReoKKse8Eal0GVMXYMJxRkJX?=
 =?us-ascii?Q?XKn9u2oTRUTmpFDKbxgbRd33jMjdpSxhvAnaeWWBfqhQB4O79Q3AMIXHblH6?=
 =?us-ascii?Q?1D0xYDPrh3U882b1rJN6Ztky7QTQiYPvXgnTqdWxayJ9J0gm2vKPGiSqRnV8?=
 =?us-ascii?Q?VL6UVVWv0AkRRPOZzXsSkleIxd/9g52hZMguB7WfOz0vrcmshmI5X4TbKMuo?=
 =?us-ascii?Q?qqpBSXlpV/izHXacUP9S9pOozJVAwxcP+iJFarTa11303f+zMn1t0EPAwIL0?=
 =?us-ascii?Q?VUajFJIG439eCudyxf4z313v79e4Oi2ABBg1SPS4QmJ4YdZY0wAWPr6uEL4P?=
 =?us-ascii?Q?fgpxxahqaBQSF7hmdm6gom3Cjf1curB1tu8NJ8gvZqc6R/ozraLl59ZY/SQK?=
 =?us-ascii?Q?gGGF3MmkglW1/LQKp+dzJQAtpk448ncJrVWtY++HFcTEwuBXWZOpSbUsspS1?=
 =?us-ascii?Q?AHGtRxs54f/EHs51Lkq40jp5VIMv1zyA9P4p2poAyK8qvMll2aG+XKvcFvOR?=
 =?us-ascii?Q?qz8IyzF6WEWdIB5DMI69JrH6b53SuAVtqm67rZBaiJ72O4G0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691cde8b-590d-4820-df0a-08dec5f2d215
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 06:46:23.3008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBxD6O3syl3uuUKvdh+LA4OFZaZbe1piq2bbtBi3eidwY+Db4s2/B467vZH5R8qkXewQM1WdDl03+76ilTihvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296925-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:horms@kernel.org,m:bridge@lists.linux.dev,m:razor@blackwall.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.linux.dev,blackwall.org,davemloft.net,google.com,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:email,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB6F865CF0D

On Sat, Jun 06, 2026 at 02:58:48PM -0700, Xiang Mei wrote:
> ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> the configured exp_interval converted by interval_to_us(). When
> exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> interval_to_us() returns 0, causing the worker to fire immediately in
> a tight loop that allocates skbs until OOM.
> 
> Fix this by validating exp_interval at configuration time:
> 
>  - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to the valid range
>    [BR_CFM_CCM_INTERVAL_3_3_MS, BR_CFM_CCM_INTERVAL_10_MIN] in the
>    netlink policy so userspace cannot set an invalid value.
> 
>  - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
>    not yet been configured (defaults to 0 from kzalloc).
> 
> Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interface.")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Nit: I don't think that the Suggested-by is appropriate here since I
merely had minor comments on the previous version.

