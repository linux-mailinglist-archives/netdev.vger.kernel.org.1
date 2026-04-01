Return-Path: <netdev+bounces-274100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCXcFSwVzWmMZwYAu9opvQ
	(envelope-from <netdev+bounces-274100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:53:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CD637AC60
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72D2A30065F9
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83372405ABE;
	Wed,  1 Apr 2026 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="avJF6NGf"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF453D5672
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047852; cv=fail; b=hDzZOjERbmNpJ9/0/wmiMf3GSWnAaFsapxW1f5OA0kDxMdhM4IiYpxHWbTyS8x+fn1bzgNDmvnqfsWWZScmG/4umpNLPO7HlJn8I4SAFCioylMMAdxStUZy34VUBBKtkNV3bcC9RRw44G1MNtSsyiANfMHnTVMO7Hps88qgrkRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047852; c=relaxed/simple;
	bh=aUHKmeBnvhcsjOECO3a+Wy1mwFsPh72LKoqXJeNaJTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iJY60F/iLOkDm/+2pnKB/nnbi86jAjYy7BquPdZHz1KERRclYJc9XqxNMYWKp+Z6kbSs6ApES9Txv82amyVZ4U+trb2fkcgaaBz7P7ki36C6MTcE12wM+BKl96vr/zD/UwoRTisp/w+e5elDE93du6zUn6J2LNjH2m5LUNuHsCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=avJF6NGf; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6vIabkR2EPfphi1uwWa7bKeBw2goahXm/y4Xs0JiOq9mF/1zt7cdzMgl4OpnaQd2QJuCEwSgy4UEY2dkIFIqfT0mpVFpMlGLBCkn3OaD3rtpuOseF4J+f/ERga+3YnG54EXwIsUT1bSd1/mN37bsJlko593nnQyVSWvA96lEa3+a6xDZcrzZ+UK8ea3ReX/pcPOFWvJQOrl5aCU+Ehr+eacPtP2FxDRBljGMdfje7PbsCN93e1n6627vml/vGDlnZtgfkNqltC40F+xHDxRBnOBoW/Es3noUqpGgEKGnyBjjfVILO6eT5FHQrY8eGnXSu8XrkumXwnokdGP3S/h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avc7s3Oog5aBfW6fZizm9N1pb6CbTNlTLYe+c75lBS0=;
 b=d3a7ZsP3OAqL1sO3zWNsjwVq4RKQ4X7HfxGIWyh1pyHq2sMCLrZOHgJYp3gd+QvQ2BjWw7knwXyXKsBvIhulFNoT13cu3z+qufsEEgJTmnbzRKtD/qLHTfaCgXena6X77hCA1yV/wRwa2qkIQTIyesLOtFqpGLGMFcJrTVpxEu/c4yEr2pb4jFY38XIBD6+Tg8pTHw8Nh9iRHcA3frL7GCF4C9dvGv9SBnB0LcyBDk0w7wa9C5Cqil31dGlNP+X7OEMFinBV4C/UUQWUvnrvYCE+yfIrTQdSLpW7ljvtfvB5nZItSvJFa2dIULGGcTzTogv3QN/5TIDpbD5BBrYRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avc7s3Oog5aBfW6fZizm9N1pb6CbTNlTLYe+c75lBS0=;
 b=avJF6NGf3xrZIZbyhaSSg5ViIDMUvQo4bkj97OXfYjRWjuoyOKC6HHngyBKpLG+dTa7Lf3dt7L+mD7csbtY05WVr9v6s/gy5xvDGpsYrO1gf+33LxByaBVtASVDFIWnNhAxjM8CvsD4kZGDLGgs05QDniQqACeCn2qtYjJ3y5mPS1F6JufHS4cnQN6YnPO08agM2IwVoMJOcqJzLzS9z2dJPa1JSN4019WpwxXrVixiMYMNIjcQ4x94egPNOYRieB9MkFVWMa98WvbQN0XRQWXxqGYNQMDyOj6gvjEq0SN1Lj+VM1wKIwj0eBoxayjzmlSD3q9kekVVXFiasLeDfqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA5PPF634736581.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Wed, 1 Apr
 2026 12:50:47 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 12:50:47 +0000
Date: Wed, 1 Apr 2026 15:50:34 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, petrm@nvidia.com, horms@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, dsahern@kernel.org, kees@kernel.org
Subject: Re: [PATCH 1/2 net v2] ipv4: nexthop: avoid duplicate
 NHA_HW_STATS_ENABLE on nexthop group dump
Message-ID: <20260401125034.GA1808730@shredder>
References: <20260401081741.4273-1-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401081741.4273-1-fmancera@suse.de>
X-ClientProxiedBy: FR3P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: f50d4a74-6040-49b5-0d58-08de8fed4b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cqx6AqsFEdw+AwepO0+JIWV/84FN6/3SNceF3y9Fazutr8knkfoWKVOAsFsGAfO6uqKPif3LdPNC2o5EtRtp9BSTIqLgOvRxt1HBXrCkpKusq3gNZHCEoKAPUR+eP/oLeH3COHNSSWEhKU3Z0NlJTHKn9u2oLWxQyNocoOwyH2Wz2RwATtZfJsgUP0lMkw241MOJM6cn3UjzJo8AqHOT2lcGQ/8Lo+XWETjQtEVxsE78pqP2DAg35qnJeaCO55Renti3RusTfX91d79Mi//b2HfSRyb4AdSWhA+K4bsgryiP9DvhWAnyCRyyPPNWxVbK0eD2eprFe0iyYTgQIJgCQx5epRsRlHYcsJsG6ldD1VyBI0xj0JGpCaozJlyqSn8v/4SyBlA4e/KwqUfs6qKZHiqk2p5lK/eI1b7lkt+OLSP6mETOrO497c6ahccYUguTvKp++jvTsmvEfKYqjnvKq/vkPk/AMmjp3JF3mwlLo7F1TP8jsrhDvWoixEhpYAtsrysYhnb+phJUQZtizJDnnhgSXT7uMFJybFdo81/lTvDHGsFYk5tgnQvAOy4CBAxMr8eEvtFRIR+skcrpy3E3vhZGgucsIabnMtliJv/BoPdDokjzB3F7Fp4dzZOqXMMAie/iDtCyBp5pAUwZhV+sU0HGubdK/lK+9muo0PN+BylNAHHJPPpD30dA6RqCvNT1jZWAfOdH0aUUzfmyYxvwdGwhomLKyHOxoO+Cup2xByY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0KSrFo/SZgg/Ph2POPC5jtT6poQdKzKb/UTnPlAYnWfEgIlIswUGxo3RPsMQ?=
 =?us-ascii?Q?3zLr+HG65ZpmBBgSGLrnY1vRSgMfXr3c3W2O1oZz1F0Vns5lJkCHmPRnF8JT?=
 =?us-ascii?Q?LwNyk8dMivuozKfcnz4UsUCJsSNyBVpkNxF81nWkC45rkeCp3F9C6ZkI+iaW?=
 =?us-ascii?Q?C8Wr/HkAXsbn8bbORRjhAEQEtCiqjgyV8YM82HuhF2vunHc7D+Fw3ZeOdXO1?=
 =?us-ascii?Q?jwaPd9/LzqYwex/y1DX8ABkHowfyrf+TiuHXPWKiRAjl+wqNGs43PzWWeXlo?=
 =?us-ascii?Q?UG2xDHhP/5pPNUHALKRhEnkooF1HciPtSNKs3V5awRAcakQeCVi4KzPLjdcl?=
 =?us-ascii?Q?+jhc5n7Fu/u06VYmrURhveENkyTD0FmxNU6aEGrnwfHWOAmu6U7xJ5Tr/GaM?=
 =?us-ascii?Q?yd2wbXpHk5jAk68+7rY6d522ubBbJehD+XBrwlaPW6Jz+FMZaIZ9SNYzMYMH?=
 =?us-ascii?Q?jlnxz2z8eaRqsaB/aVi7JZPIXo+/PUou/Ee053sGxxwsJQXZ2BlIxjJiIdOK?=
 =?us-ascii?Q?gSazeH1sjZxf2hu6wsSeBYRMn6slXyV2ZFXH9DbN16Gqek1Yn/vBKHXv/HwO?=
 =?us-ascii?Q?2KB8sTopJXrlvOU8A/YkZxPD+yuFHQlq3XBN7+z5jkVKWo7MlQRD5ZeiHii1?=
 =?us-ascii?Q?gYa4Hi9XafWlqBdkrMwgVozCowphLclrzdQ7ppIepEyOZiPad0fQNAIY13CY?=
 =?us-ascii?Q?qR9gEgfsZUNs8d2tiPC2umBV6MmfYU4Cr14pHfoV9i3S/A2GeSZk/61KmIeK?=
 =?us-ascii?Q?k88cAEgnjTDOT2j0y1Lmgu6cwG4wGPpmzI8w+FZ4DFLzV+lMNBad/wBjecVj?=
 =?us-ascii?Q?dDTqJVt9oMH1KysW64jFyc5Opdj1Yu1ya2MC1u26Wq/6CNsoa7A/gwYFzo2o?=
 =?us-ascii?Q?qxa1hhtkA5WBu8TzPMZJ8BeL+C65GcLHVDAeHlL7qhB5Op9q8WCMOmlvFmto?=
 =?us-ascii?Q?Qn/OlnkWyJgpV8B/17pvgtM1H0T4InQlmiVCmXsWmFfFk3Anq4th8+xIRe2i?=
 =?us-ascii?Q?hPfqhJ508aSstkWk1vabkA0WRxCGOe31vVSZf+T+McLWP5Vp7I9LM6l7y2tE?=
 =?us-ascii?Q?zP67/hs4muAMWBYDDcF/mMW8CY0+KNcbGrJ+YI4asmbpXhi1zQ7V4b/z+tOJ?=
 =?us-ascii?Q?NqlLVS4Gw3g45dNVfc7GnvZfKLMcge+euNd+PQbhPjJ5LkjQK1AfdPwM4NPK?=
 =?us-ascii?Q?IEJQPWwe2fhDENkyP91S4pfdKHcJlrouWTl/0wbZ+z5VRntLiF6/bQRsvT76?=
 =?us-ascii?Q?T2gvYDeOeitM5lpsIm086QthGYqJdthAmpz8FWUxCEAkINiHuG1lB6zMPypF?=
 =?us-ascii?Q?zpFY+/KSLj1iQHPsX6A8Nl4E21mnVwEn7fQK1sVkLTSVhlm5x+EHHNsoxrcu?=
 =?us-ascii?Q?dsUsxcj7gfaDVsbo3ZEizwc5vrwqrjOj/+05Gp8UWmJjhgz+7cDeiqZGRvjr?=
 =?us-ascii?Q?RRc4ccyVB+oET7VU/FIxuvok0bi1yj2FIFX7d+VmckR6XKFquVRN9XMNuzWY?=
 =?us-ascii?Q?56sNoOWnuAm/BcUC0qpPuNI5znbrF3gxCP2AZ7+XRrJqGtGa3Fb3B7i1k3f0?=
 =?us-ascii?Q?uIBCcIqHmvWpUUJ3TT9upw36W17FBmmVkru1pzDXFRFbBfdmsvrEoQUIHGaQ?=
 =?us-ascii?Q?k9gB6PPVzwNQu8i9HBpT4em+YI65F9sg5iXqoaYDbo4D5TPHgYulwIftZEqn?=
 =?us-ascii?Q?df92uNj5bYdOXsBoVYG+Ljan+2gYUtCVuAyRavfZVPANCx6ITnHse31IowLV?=
 =?us-ascii?Q?MR7hl618Nw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50d4a74-6040-49b5-0d58-08de8fed4b02
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 12:50:46.9201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1l3di0pEVhr0ZkQWPWoDqPpq4ckZ3Cr3e/4y3FneDZlLlH8Fc5W8iebE7fh5IZNOtNzmBx7LOUx/L3iOKPZxSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274100-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: E1CD637AC60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 10:17:40AM +0200, Fernando Fernandez Mancera wrote:
> Currently NHA_HW_STATS_ENABLE is included twice everytime a dump of
> nexthop group is performed with NHA_OP_FLAG_DUMP_STATS. As all the stats
> querying were moved to nla_put_nh_group_stats(), leave only that
> instance of the attribute querying.
> 
> Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

