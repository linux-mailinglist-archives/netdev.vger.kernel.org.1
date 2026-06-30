Return-Path: <netdev+bounces-303305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fNXbDiX2Q2q4mAoAu9opvQ
	(envelope-from <netdev+bounces-303305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:00:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0156E6B27
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:00:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=jTHnW62S;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303305-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303305-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16ED93002F64
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF27D3D75C2;
	Tue, 30 Jun 2026 16:59:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF5B3D1A98;
	Tue, 30 Jun 2026 16:59:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838790; cv=fail; b=XrN6XbHrkMhop6Qf9o5XAAE8o0eae6q67Z+daN+yaVh1OWXqAkWiHNploGrAxqfeC1nq3bpG4m6MrfVNnJS64HbAAkuKP1ABN1uCmwTBjeNd+HbBB0ERi9eFae6iuwHhDZXoLdtUUKNviItkkGFvUsKaF+BsFl2JwUvM42ecy+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838790; c=relaxed/simple;
	bh=6QcriztBLgpYwWtmjoWUm3h5X/jgKia2CtvMGpVx6UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XVEMrFyK9jOJhvJYlT8sRbFYm1kZRfcR7Ne53ZfzSw0UrD3sIhMjoSboG3pITF8wTHRKPbtrJ27u8eFLXpjnWYTLyyoKcuML5bSd+7pLPz1zC3H8edFDuoP2zium4ikHtxxXPKlEIdfLRjvALsjucitdKxhb8DnQqZul0bR+AfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jTHnW62S; arc=fail smtp.client-ip=52.101.43.62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q75GquOWdRwlwZJ7GlegvKdSAqBydL47F/Gt95qeM+DzLMkks4jsLhzJXVsxWzosv46uzuGHog/+7kkZ1Oi/N1G2iuJmfP++2g7WiKPyaD87I5UwANxtAMD4bdnzJKSbQrK8/4ayKcMOwlJX0m2IMn+iAYmtdo++s8Ux536L9Wbod4QNcRLPQ9+kYKXzsi5LvanaWyBTqDl/uVB7Y/ysuab1XSe2Db9fnRP5lads8sa749UYUH3mj8uT/olfWccbaXUJfBndMEZ9uwPU/ZI3qGHtdB8sSqrDek9XMKA1A2nzbm3pkFCV1ju8uupKR1zPlmc0E41EMq4yhEoW4+i06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFsimOVJ8BiMe/u4A+x72ttcYJzJCE4rGE/X3iYIayI=;
 b=knJ8x6yLisC06FLqSxys2pOSZl/UvjJZxPDMUF1Yuooy9AtzlDkauJIthv0CoQTCfFqI/eavCCh/0Hiunzev4gpn3EZTCL+JilusqRYc+9JjkfHmgdF9j6faA4XkhTB36WMZoIwqtqHsFId3j8CDNvdK9r1/ioLReTOkDloDxIcM4lrEa5rjCHroYM212A3a9vNjDBiekcaYsOZogE939cgadiuqwDC4r+xMLzo0Ted9fy8wvnyiiDh7Qx0cIBEsfSepBwAx4Z+o3/JlHs+E6kBb4/L1txIuhEtMWRYeyu3kE8lYCS1nzoU+8p4H/lBGyb93W0tOvUH6ZZeplAFEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFsimOVJ8BiMe/u4A+x72ttcYJzJCE4rGE/X3iYIayI=;
 b=jTHnW62SlkmnGEM7w40+wPsfr7hmAMylI9jeb2Q0buNW/h5bhH0wYhbt7SH2lzcMPNXJNbP3ysRZOSLZjfLI/4jdhI6XRbpPaEl4nhFWZV7kGYuITmipzbeCfbl1Zqx5DfNGsu8jVySeJh/djIKWdeDCg5ObjRR796h9rHwh9PurCW5YldaG24STCzHgBOS+yOHWRdntAxNFleqhVNPbVEDfDgNNy8dMmLyV+pm6fqsKfIIGhNlUPrLFSPC0q0UV2GSSeraoooemJJ601Sf+4ZAXctTmTnPLeVcbqkn2p6GvnC9OdG1AvEzNO9Ujf2AQBlFAwKX1fPllfE9RQm23Mw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 16:59:47 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 16:59:46 +0000
Date: Tue, 30 Jun 2026 19:59:34 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2] ipv4: igmp: remove multicast group from hash
 table on device destruction
Message-ID: <20260630165934.GA1227354@shredder>
References: <20260630022325.1556638-1-yuyanghuang@google.com>
 <PH0PR11MB590210EC36E866B973378054F0F72@PH0PR11MB5902.namprd11.prod.outlook.com>
 <CADXeF1EyFJ1RaJqJC8UB=rn5Jd5GLU-2WxrvpW_buRg3O3LMYA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADXeF1EyFJ1RaJqJC8UB=rn5Jd5GLU-2WxrvpW_buRg3O3LMYA@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c986c2f-6ddf-4f3f-b871-08ded6c8fd72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	GfyMGAmMiT0LMNMAsLrzs6dc6V/1flS62lvC1UF0LNivs7ONRVzapXIAULTKL/0LCD/IMtuURCawD9mPbujO4sYNdszla/5SW+r7jsn0E4GvcNlhEYExcPD6aTGyW9GXIUnCdUuJY7OB2LCJS6bOl/G4RUaVNWh52GzuJi4wUdz0jnFlOKmqU+SxyAME28Hka8vwkzC9Nlpvgj7qHau6077/kWd2Xw91LW0mMd3t2093Ap6vAm8qjFq869zup6qqqhmtZ72+HlqM5O3S0/kzZI07Qh9h0igI1QdgzsQivwXC98d+tvpmwfWAYsairLGF4nrEa7CXjBxruslWV7rSRtzoU/fYBjpX/6ygps+l1M86GD2Lb+ZTPCqBi6TVtmyCIcuDTD2bHLhCJZoAoLjJG5pXKcJ0YXqt8VR+IiBn1hyyLkZyOdpTwcERg/S+rQfN9zkuyOl6ds5kRl/dMP8PlkEsezw5fTkUiWemsxdLCTrO7I0MeDj+sUgQT4rTLUcR6Jgdm8eTwASc7IkB7oW5g7LmhNmTiUUV3ToseC2wpq4wqJiKYsGsxw5NMOwiIaISfWc7yj+TobXldkJDKUSVkuIaJ/sR0lZWH9vMw4ABq0wyAjOUsubCTlcZkSQyhWlo6AuXe0gzaQah1ykJFNdCIxqzQLNyN1FtE/icZ9+CcbY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zNL1aLAxE1fqGtshtWjKyCk+0BKQTSp3NlVYd8s13/3loPQbyNvFZ1CbkfnH?=
 =?us-ascii?Q?IJ1HC5wu5FdLpWIQU/jqlUXcgUiDJnxFMYayuay5KMSTEkG5wCqrYcheVwwi?=
 =?us-ascii?Q?SdvdXfwh9u5eFxRgvmbT7cyjJRgswuV6xMwIZlgoh/e9NdTKMr7qVmFxMAit?=
 =?us-ascii?Q?Of5E6R1LAkmuKZKaXFW3rPhQlGCGaUMvqtUcf3Dd0OCChQMzcCJ/E/VEymZ3?=
 =?us-ascii?Q?Di4fR0shnZ+MY0qcNXYL9tvI1mcFEQEmmuViVxOEUruNGFkBB8BW6A9/7WS2?=
 =?us-ascii?Q?WKY85J0U+2d2R3sFyAPxRiB7gMcvTyxagnjUeeXh/v1Hkk4uWyYyCFVfhwte?=
 =?us-ascii?Q?NuTZtLnEIVTKWDXXX1tmYMnukaOiO9Q1gAUrExz8fva7ZUrdDIdCm/wnsYxp?=
 =?us-ascii?Q?6FpiDGdYzNrd/5WJ1P0r3Wg+io4BmFLqClfYh5jMi6Za0lUvqGTiqwvp4me4?=
 =?us-ascii?Q?6/ay4Au1BJ6xA9MVwpY3c+sOHZJ4UlNrVIWFS6BUCDblKkTZsakEsP23Sp3Z?=
 =?us-ascii?Q?8qTi7ZL8yrKY6S8nDI/XjXqIognkGPphs41xAzRms+sSZUyeHJ3megQySmOv?=
 =?us-ascii?Q?vpZ4r3SgIvVTHx9cjgGP3P3AKG7ZBYU9ijvcbEdLMOuDNG+es8lGqOhGpWs1?=
 =?us-ascii?Q?4R4mb1EX4hvDtvuhOhJ7N+GmbOqVrMhO3XMnTKBnlEUc6NqhDomCQRwZEzEN?=
 =?us-ascii?Q?44BgKNN2HXhURpjaj5CLmC8rbDAYBZNvYbhEk7H8d2nUnFTuCUYq1IxDXbwk?=
 =?us-ascii?Q?4CgkPSuLqGdGoE51IJe6TeYN+ZprUSCCPQpktW35YemGUn8EFKVQoBoHxDvC?=
 =?us-ascii?Q?FEvGzD5rMOGnmzLvgEIQiRAyXOWUfJRXflLNQJ7hr3EIoJ3FWBOh8hadVAWJ?=
 =?us-ascii?Q?egQvFV3ZZnFTuLdHhD2QFlUaks3+S+dqmQwrc0GEYPj3cAZHn4UxrFbZ+1cr?=
 =?us-ascii?Q?4ixaKBNkMiLawkFqAftmoCiKO9oEJVuW3vbIoV3WFOC3leNNITXpbFHnw/nl?=
 =?us-ascii?Q?GUpDHbaHV21XFY8LnqClRsUWF9Dc7IRDTyevzBDst2CW9/2TKJds/eIuQIRp?=
 =?us-ascii?Q?pOUvsYWEXu0fHy5s62IDFnP8rujBxI10K8FMhy8DfYcqDWQjmg6BuIpennEr?=
 =?us-ascii?Q?eDOy+tb+KQ8w0LqxTMFpi9DpriELIOVU1HUTzw3LgqAO73bmFDYrHJxUskLN?=
 =?us-ascii?Q?MBGgc2NiPgXuTJH4W9q5rWzK90fEhY32jh2MT6dMZ8HMqYJW/uop5nXxFVNv?=
 =?us-ascii?Q?e3SUv53NsV5JzCZh0au7BC7FJ9uIqZzhmtmsLWuA39anrPbfmLtBoc78QW7C?=
 =?us-ascii?Q?QszbIUBHfb362Lq3F2Q04pyZ/IdhyxxdjJy+easJ4sFEvw9CUs3ixCX2gcGL?=
 =?us-ascii?Q?e2/NJQhndzEp7XoRfxUYtM35W8EgVJF3FmsTaD3G87Ta9v4ty7+v2gWRgWTC?=
 =?us-ascii?Q?llvR1QOwrTPLytNGPixULAkoleAELcE+3wwaShTanD9p9QrThPZeUrKmWn0U?=
 =?us-ascii?Q?GfCm9SMNw5BriKwUSj7vh4ZYBVmtMJfPw6KMy4bwKr4u65N+iVv5SpGnIsvK?=
 =?us-ascii?Q?zHcpTyXxQCq0FNICFjovhPX8sX3R5Mnv+pO0oEB4DCklq5t3+gHoUmYybI2o?=
 =?us-ascii?Q?PUmtLhLyJddLc5zT7nQQWnPhdtY1IzbtHOSWEZVGUOvcknLVAkBeirldETDE?=
 =?us-ascii?Q?HpkglTQJ2YGkaSjQk3ZxTCPG7qrwjvaGEock/yBAK77l9AFluDpu4MQpepwB?=
 =?us-ascii?Q?2n5SW0BSzQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c986c2f-6ddf-4f3f-b871-08ded6c8fd72
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 16:59:46.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AkSkTJNAEsINgiSOAopjh5gg8X4QI7ygBdcMOQvKd8vXk7ByHRbaxw6S36oF8tIZlm2fEGV89C0d+IR9zSU9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303305-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:jedrzej.jagielski@intel.com,m:davem@davemloft.net,m:xiyou.wangcong@gmail.com,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,kernel.org,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E0156E6B27

On Tue, Jun 30, 2026 at 04:55:22PM +0900, Yuyang Huang wrote:
> > Hi,
> >
> > why sending this to net-next not to net if that's a bug fix?
> >
> > In the v1 thread it was said
> > >This is a long-standing bug, not a recent regression.
> >
> > so why do not cc stable kernel to get rid of this bug from
> > stable kernels in such case?
> 
> Thanks for the advise, will send this patch to stable kernel.

Please target v3 at net and add a trace given you're claiming for a
use-after-free. That way we know that the problem is real and not a
false-positive from some tool. You can reproduce it by adding enough
delay in inetdev_destroy():

BUG: KASAN: slab-use-after-free in ip_check_mc_rcu+0x2cc/0x500
Read of size 4 at addr ffff88810c571208 by task mausezahn/419

CPU: 2 UID: 0 PID: 419 Comm: mausezahn Not tainted 7.1.0-virtme-g15d4a7c23bf6 #17 PREEMPT(lazy)
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 <IRQ>
 dump_stack_lvl+0x4d/0x70
 print_report+0x153/0x4c2
 kasan_report+0xda/0x110
 ip_check_mc_rcu+0x2cc/0x500
 ip_route_input_rcu.part.0+0x13d/0xbc0
 ip_route_input_noref+0xb6/0x110
 ip_rcv_finish_core+0x41b/0x1d90
 ip_rcv_finish+0xea/0x1b0
 ip_rcv+0xb7/0x1b0
 __netif_receive_skb_one_core+0xfc/0x180
 process_backlog+0x1ea/0x5e0
 __napi_poll+0x97/0x480
 net_rx_action+0x97c/0xfa0
 handle_softirqs+0x18c/0x4f0
 do_softirq+0x42/0x60
 </IRQ>

