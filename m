Return-Path: <netdev+bounces-257849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBP/Kw24iGkrvAQAu9opvQ
	(envelope-from <netdev+bounces-257849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:21:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5689D10969D
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63AEE30041CB
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C957289358;
	Sun,  8 Feb 2026 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kNdPdGrb"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AABF20DE3
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770567237; cv=fail; b=YcIK8Zgo8vvZZZW4kE7rDlpfhEbkhLu9bbxQOGBP15veBrG6JXoWhL4z1ObKKNWQWRMsuS0pC/+LIpXY97qWxZztmCeXp+PBTvLBgLHcfQpRSlTODTg+AFxWro/nvuAE7u+txP/tQPkKRoCKi4lBAVCDU6jzCPPutKIA+iMHlbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770567237; c=relaxed/simple;
	bh=mQyIykgS/d2aUndZWPujnYgC/7zKw86Mf056HVlJq3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=alkM0nXhQzv+rKLxBpHvkwfRTKI2i1a78y8uClRIRC3js7FNq4gJEiOx4R8c173J1X1SifGSjSSJ0iXfa5ZKIk9uiws4jD0swmBZN45LgA97wUvVBVlxmXpzqXU7eKtv6aXUqAn7yk8i6WKO7QYqT408/3UXhTozhol6e/VmKoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kNdPdGrb reason="signature verification failed"; arc=fail smtp.client-ip=52.101.85.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uY8KGTNfGk16V/zjbiqdei8Y10sdPBDdRC7xGzZ5msDEQaWp2L/b2bFs36xEp4rsOHBA4Bo8s2xdEHoJvCss53OcnpfZePT+JDmZheX2IXLyF88NHGqw4cOgU3T6AIplqiSR6Faq4oi9U0d1DsRRrqYrSeNCDNMqfBqkfHczjDMh4IbW6FvdCLbLvTUXOMcShTmS+KPBjqCOS/u0wS1LRIyawKps9NjavzH+Y3ldkXV1dmLaPjDUqK7Y0VXi9pH92OamCrm6WXi5prqDKCXX+wNFzmuD6/Wf9bL7+5ZxFMQ7VJY+Gio+pTZJCWs1PfG05j9/5uGXW+AgQig3rhnUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfammHYVhz0pez6IU0YtNIHe6OMBlvbAvDaFiPwUfzc=;
 b=kobPDFVHR5xGVpyPUs5oK5OWWB4vRPiRB8nV8tYQsZJia8enTOaYU6EzCIpu/OmZxvW8rcLshQHtNmqeTLQ1PlC2pvkqq/gtOwe4oq9Q6AAIubBRpGSD2DDNWmyGRhhFzV8czwlRFWto28lQj3FxLa81sQt5CP1Y4IKY0TD/r65cPtl8uUJcnRtJ1pqfQU+YRmZBt1t7MUZQHCUDZMreM7TDFsHAA0NlQDQfkO5NGiKicspcRqX5LFGDNu3mw4/Y1CtrKKoglVjO/amN4scwVkWr0DYh3ZcMXfkeriUuWIZbLxErfLruR4xKWn8M/LgJ9QeEJxn7q/x2QrQcC8nCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfammHYVhz0pez6IU0YtNIHe6OMBlvbAvDaFiPwUfzc=;
 b=kNdPdGrbeoLsRfx2NUKBL0Il/QzyN0B3p1vVIyAE5faO+KTGGu00LBmpZgYapkMH7rJjDKq7Iw3Wznm8kBvXGK3AGcU+Cz61fzLC+dFHEYkXVYUhZXFqQUZtauyy0IhvHDdWe0e3GaghfDoVTccyzFgvjk3WcDhpD9IjnigVVs38vnhyD44o1YSzhUVhX3FaqpHZrZMEKfqeZxeIU812foEOu3rFlszllFz2msDFcDwRkL3Q6NXKnh/SKVdll+sIFPqkEEZfFW0X8Y+25hvbXiApcx/6YY1v+MpLR3+yKvauVhBN90EhRCAM/s4tckhX37zG0nA6kSQEKR1Qyv+STA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:13:55 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:13:55 +0000
Date: Sun, 8 Feb 2026 18:13:45 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH iproute2-next] bridge: mcast: add mcast_active_v4 /
 mcast_active_v6 output
Message-ID: <20260208161345.GO154003@shredder>
References: <20260206023704.4839-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206023704.4839-1-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR0P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: ed15a487-df84-4db3-28f7-08de672d0ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?UbOR3TG+gr2Fv3rRAGTCgdHoxmXH2+ctjkfyZuZh0wF89ymfdonR2CI8M7?=
 =?iso-8859-1?Q?uwo+WLLjOeDWvTEFLKMi/2WM05U7cM2WfO1iQuiyPFwtRse3GTvy7LIAzg?=
 =?iso-8859-1?Q?h1a9sPQTfylqlJVzoyNT1HIQgkdZKKRm2oPZBwGUcm6/MiKregXE2O9bzQ?=
 =?iso-8859-1?Q?2dbdI+CgxIUlULnIQ4JcuasELBUgs1wDN04whA1ooV8dKsCat0BOhu6tdB?=
 =?iso-8859-1?Q?UVQ5s9qgmAzHqgl77J9XPb4P0rYnzkn+jOIQgIICAihCIW8wyQZXW23Tz0?=
 =?iso-8859-1?Q?/FTa5geS1GPDElP8JhnqUEQ0fjy9VpexA8Sa5kT154nr/e/XgQgCISX3T0?=
 =?iso-8859-1?Q?qjPRzxEwMK2TdQhV9T1svBy1SaLgDeVZcNMLhAqDkuExkYkh2ESnetTBbd?=
 =?iso-8859-1?Q?/MVwvQ2hyN9SZNYRKD/vOuRMgC3zSO5IQkW+Fy5CZGsI163CGiuM+3hBNg?=
 =?iso-8859-1?Q?tWposN9rYuMTpKzHWBaXwwFnQaIj0kH1wWPE4nvSLHHjxtkFn0l0H5Vh8j?=
 =?iso-8859-1?Q?BqEmGrqvPKlmL0ghkXrOWnFEJr8TaBxpyGazp8KCjph1KW5GZ/Kyh6VB/v?=
 =?iso-8859-1?Q?E4bMF2zU/yVRQWqJGwmm7gw4gZk8h4EoqTmX1ff2pKuzNvwdSAQMeIoz9i?=
 =?iso-8859-1?Q?Qgy9TtZGYwQIkk1GDeHXx018e0TFrSAP3xd31Oc5dxf6u4TazFe07zMG+6?=
 =?iso-8859-1?Q?svnjpsBXFlIQ3m2aCAKYhTYeaT6EctV3p4Dcds/ZXMnGmBd2GKDjnZmEzJ?=
 =?iso-8859-1?Q?/eBlXcnJgLDFFHF4ptmAOYCVrx+QRh4E2PJs9KX1vIFv86wxVCAd8nRqPs?=
 =?iso-8859-1?Q?1JEghkjY0KGJC7pdVfPIX/OZvni96/+0Oe01zRN+KbuME9DP15+0OI73hK?=
 =?iso-8859-1?Q?KPe4DYVzWiyEvMax224GtvG6lM7A9Kg9z4ZeO9eaqkt/njdXoqIiDyhbbd?=
 =?iso-8859-1?Q?cRv2ssFkjZXhSewB1AJtj9/z0e7bQId4gZl4Wym5W+nqhj6j2X7Ymsm099?=
 =?iso-8859-1?Q?fbv6RCiUZ1zt2h/59q4KzXuZv1k0QqsZKeIBE108nd9sgNy4e4KTq+3ReZ?=
 =?iso-8859-1?Q?6/LNdEQ2wupsG3g77iAlnBfXDDuYguYcFp2bl8GoHopyDgYB1v3nvTpc+p?=
 =?iso-8859-1?Q?ep8KTfKcw/v+UeOCrQOSfoWRJK7ZXrKgOJQimGn0HzNuqHaDM00TI5JJrO?=
 =?iso-8859-1?Q?OrbIbvs5laJTceKJlTq4HWi0n5wzXc9YVFB8bZOQLToUV3ocY66EdSmBjt?=
 =?iso-8859-1?Q?8dJTdpDMo08tb5FOrIBZfRIOwBeUn3NKElyt1e77q+LmkSdK30uMRdbQ/6?=
 =?iso-8859-1?Q?AjZPLmGpAG9QRDLHqGchOmQK9D4Hk4vREysgQ+8Od3T1AQn0mDbh6AmpQa?=
 =?iso-8859-1?Q?5hsIdRTa9QPgBc+f7LHc312IuxeMa0SvSsYxOZFoqH1Gqd9HfKUcx7lpxG?=
 =?iso-8859-1?Q?DPUckKluoS6+gdudOIkfXQS0jrrHcaBxdQ7lp/SjqckuY+KRVu3zMrYKpP?=
 =?iso-8859-1?Q?vLwBNk+lPhsl9BB2qWHzvnm9gYQre4YWMirLgBZoBXqFmiV7ffvvKTS29Z?=
 =?iso-8859-1?Q?yQMSspCrUN8VfCq7hsk9tpNloyR/qBZKT7hjA+uOYPco++Zc6cppTAyNZv?=
 =?iso-8859-1?Q?0yxFz10Qw5b7g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ZU8xQYOZ4KDUX/LNclm3Q7zKpS2wJZSSF27rmpoeXvsqnffXnoRsJNuNYY?=
 =?iso-8859-1?Q?HSbGhTkMfZatRijhkDl2z7faXVsCFZtMtl6jKpYsBOtMhb76oNkjiFJoqP?=
 =?iso-8859-1?Q?YxnRJ6ZW+Xuta6M6dLTxqUpIgkoX9ph+M5vE42lA6DgsxcY/IenxQU32Ro?=
 =?iso-8859-1?Q?y1Kb5et915FW/JX3QkCqx1C2cgwzeM83NTn26EztREU7dwHRyqhHThycqS?=
 =?iso-8859-1?Q?mt1Mmh/hEGcT2pwp1HcoP+oY7As06KOhS5KeEDfiOi38qAE89//B8uh+ng?=
 =?iso-8859-1?Q?arsY2F3ssmXc+1rcC0ihU9oWe9/U+wQCJyFv9KdZCkrFrf+wJXmH2TEOiE?=
 =?iso-8859-1?Q?YSIrZ41K651gBZcIHxfXLY9EQzKyXh13J4rETAX+Dv2OROAMV6P52Q/kAv?=
 =?iso-8859-1?Q?S1/Xw7jbjjXNXqzdNwO2mVeQPFgTEkEa58r6XPMZBpZd/s1jPY17iyONFf?=
 =?iso-8859-1?Q?saAIcK299wQNZIY/slP70fE5SEEDeM6gRdCP6n4H/AWQyhPIgWMXrFeFQ2?=
 =?iso-8859-1?Q?9BsPt/s/jHhXqT82ickQPxlxze8r/Tjzt2Xqy4BQitsEYj9ROa/Cdbbfys?=
 =?iso-8859-1?Q?DkU8S4kUfYwtGGKvf7ZFgU5pe7Mojtz3cqT+B2xt9tqmch0Vojlz3nxLF0?=
 =?iso-8859-1?Q?MvO9bD+foSw5XeBxZPS4CjUGFrTfRb1PunsGzwoKnBiNuYxWh1Wga7BcGj?=
 =?iso-8859-1?Q?EqA6ljitZ4d9I98hfN/0zXeU20vqkpCViyn4YLbGL0Mtc5sRLk4/uO7EYM?=
 =?iso-8859-1?Q?6DzJ6/rmgTtgPNURr3xaWR31pOndbcoUdAUGvVMxxGLCae887zDiegWgFG?=
 =?iso-8859-1?Q?K0T/sF1Y2gu/Ms1Wz6oWKlFDZ6KJk8pg65E1WTX3ZB+3j4jIDd0ql5l3qa?=
 =?iso-8859-1?Q?PBgxwg/z30s5oMXoNhnlhqMr4opYauAAWCGWPu3K+Ns0Ark20I/V41LgxE?=
 =?iso-8859-1?Q?JUv03LLGQVkxi5cmz2T6MTik7nLq4aL4TjHRqv+axGXE0SJ/ZPUNtWWEtb?=
 =?iso-8859-1?Q?nQozghjwqGglpnRGhLL1Q2/UDvzoBZzpod7dl0wsJHAYaZeMKOVOSy8DhR?=
 =?iso-8859-1?Q?2wXsFBaPen/r5hVGVVX81hJzr4gGaQw3lpqNvTriqPg9OQ94Bj3i6kwL/D?=
 =?iso-8859-1?Q?Pt39cEdAojAcyxBMT8WIfByK0EjAk+Zkqj9kJutu7GiMIxIook5OXDDOID?=
 =?iso-8859-1?Q?JOKjMkqKu6c2fdPronQ3B/xTJPhHny4cT+0shl8omticwAoBvHmyLkwkxt?=
 =?iso-8859-1?Q?IzhUEVLzNcGlgwSqBEs3TmIG3wMOMlcamRXVH4MVu+/GzuZo/siPAfAuCQ?=
 =?iso-8859-1?Q?XTOMSzu/77OY3dkpgOhEdL9ycRltLgNiYim8Sduc85K/PTW3caFCS8rLY5?=
 =?iso-8859-1?Q?zw/r+3ufjEbaN1wBSCyTQA+N4w1lzgCS3Hr4g4m51uMu1OfKACdERMshAV?=
 =?iso-8859-1?Q?uLHnG+ZiBCdm3JklAxfihp292/GQJSQwkDYvc4W2h/4QgobkbEbHgQ0Kym?=
 =?iso-8859-1?Q?p4ODfOvXgUKeafBLWHqO6A/IpoGWWJpgiysaUuoguche0HBQf53gBeo8Uz?=
 =?iso-8859-1?Q?IkX+9lbU4qPLRY+MjG8wNJdZT2DAW2ZMfY8ATQo04UEeSoDrUPb863MuOS?=
 =?iso-8859-1?Q?tZDzeNY7v7d2FMEPcEQAsuPfgO4nPS++FhdEyEul/fK+3BEF1iVnVv3tIQ?=
 =?iso-8859-1?Q?K3MIycKlYXETpkVfws7w7nPiQ+8WUYgP8Ggpv7gjevHNo+YEqJu9WoAPqS?=
 =?iso-8859-1?Q?2gfqTL0pB/+pQmWk3Fcg8bCfNRes9Rbhp/znx8CP+6rpYv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed15a487-df84-4db3-28f7-08de672d0ead
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:13:55.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elcyJGwtj1GVkargSlc95zw1CkWUiCwES2jAmGkVSm2mgUskFJkvCCfYSXMawH7vY7yA0xrkEzoysuHQw8Rzlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257849-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.966];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5689D10969D
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:37:04AM +0100, Linus Lüssing wrote:
> Add output for the mcast_active_v4 and mcast_active_v6 states. If their
> output is 1 then IGMP/MLD snooping is applied to multicast payload
> traffic of their according protocol family. This is the case when:
> 
> * the bridge interface is up
> * multicast snooping is enabled
> * an IGMP/MLD querier is present
> * for own IPv6 MLD querier: an IPv6 address is configured on the bridge
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  bridge/vlan.c                  | 10 ++++++++++
>  include/uapi/linux/if_bridge.h |  2 ++
>  include/uapi/linux/if_link.h   |  2 ++

Code looks fine, but note that David asks to split the uAPI header
changes to a separate patch as a hint for him to sync the headers. See
commit a3ec2778576b ("Update kernel headers") for example.

>  ip/iplink_bridge.c             | 12 ++++++++++++
>  4 files changed, 26 insertions(+)

