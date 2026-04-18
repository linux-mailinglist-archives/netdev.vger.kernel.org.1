Return-Path: <netdev+bounces-279515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JN4ADEyq42kAJwEAu9opvQ
	(envelope-from <netdev+bounces-279515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 17:59:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3BB42184B
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 17:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85A6630330A2
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C2E2F3C0E;
	Sat, 18 Apr 2026 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dwWBzC4l"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC062F363F
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776527944; cv=fail; b=fL1Zd9vd7ad1fKWh4sg0GWQSzlycUCgALT04KrSciHZ72EcGNzjz6Um6jLiGKSj4WwY+U4Tlw7fCr9QSPoUcj2trCYV6rT0s/EQsIbdaORXTe280WwlNdA//j9CMMnP9L7ZECLLSkqKnYrIVK/YI179HGBPbHbDP26zSrWNBW/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776527944; c=relaxed/simple;
	bh=0rPnaqT6VgVYYC1eupsO0oBRmwh5CXMl21bgV9xXeyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mfduK3vUtzgWia+d/D9GmdYdzRGm+H79ZTeBqc09XazCAq8lzSPX3V/vmeie8el26ULUHXNDMsS4qBUyrmlr280wI7q1AQjp12y6i58tvqEtRt/7hAmg43MXiIb91Qci3mJ6joCPrnr+4u4sV3i8R91LxFS0jgO5MYpzJGqy504=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dwWBzC4l; arc=fail smtp.client-ip=52.101.46.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiMd/5VljvW9/RlmaykSvPdHEOfFUgO4ZfNr6kxSZtaDHBaCHVhVeuWXtV/0lWa4Y1/CGlyiNVBJcE++oyOdB6bwhtdmpw49nI9hxeotFG7MqIxzdXk0byOr7aMqay0KIjSBhgky1Fb2MsrxQo5mc89zEFTZrU6ceP34QJUx9zup2judNm5b4QGTS2MIb/UQ5Ph6mzPcj95XIKuhMw7Xp/O+zk/s8IEKdPcCFJ+Of3WZKKuRUi+nAZovsUYa9ZDNCJhwYoaP5vVU8qIiFOpJY2TQQXUvmhOUCxfWMCVYwuPLfkTUvn4y2ukT1l8G/7zWVciLDniYfoMESRmTz8FVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+BQTkSa0spB1DqHEJDob493O/KRwqBmx/cS+8b6tN4=;
 b=DPLYLt4THyCHP5GHBq0U+Jkc+4JIVSeIc8bpaTnq53Fj0alxdFJs1Ou6/H+/dJRxRHwOSP6Fzpovt1eYFleUAkFrmz7yGWCcI1oS+nHhu0zHA0QwGVzoguvFPtOUmYb23g99JowN6fglV5bNu1qiEqwP3B89/coIJZP2t8vveJ/kyF1xl3gMM/gQ7W6csxegL1Kl9zPqN0T22O314VC8ysI/LHDVPOEzM+YNIslgohIJXSknbB+6WiXcX+fPBXSFrKh7HYBgXavW0q8JiEHTE6dPKEZLqv3AvvcneYgsclbnxpcyk7iNXLCjsA5ah5IwoVTvqK3FwrGD1HRmm10rbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+BQTkSa0spB1DqHEJDob493O/KRwqBmx/cS+8b6tN4=;
 b=dwWBzC4lWSxlD2itPfUjPRmrs6/iIkjhNYlB7B15dJ5rEsTLdSnqWmFHni+J9cKDomIq+c3sx7fHqn1C57T2W7gXhfs4pWCdW4cLTNg0sO3Dz8TIiHR32JxG8lSyr2cBTKsn23dZKPeOzbltbpwUob0uOXmKRHveM7jWEH7gNyPaFgNSAcvseRlQOT4WsA5oitXzkOb1q1pAwGQU3N9U5YjtDVjIctl7NBPdktUOUYJd1QwEvHxW0c9i/nBdXK901JbmnpzS1TYDxSNYgAD0YBXAMz6AIastCrg5LPfoZ8AyGGMc0SYKW1eixz9Dx81ZifN9vg2ZaPaNf+x9fO9O6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Sat, 18 Apr
 2026 15:58:55 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9846.007; Sat, 18 Apr 2026
 15:58:55 +0000
Date: Sat, 18 Apr 2026 18:58:43 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] vxlan: fix NULL vn6_sock dereference in
 vxlan_igmp_join() and vxlan_igmp_leave()
Message-ID: <20260418155843.GA808294@shredder>
References: <20260418114110.2602784-3-bestswngs@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418114110.2602784-3-bestswngs@gmail.com>
X-ClientProxiedBy: FR4P281CA0435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 37748dc9-7342-4566-28ee-08de9d6364e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5lI8pi/CTQcgrnAf77vLvBkWChb3gU6GDIDH77Hfby7bgKYIROAzv4PEC5QOA+ddXiXRJNPw9hNacBUADdLz7C2CmF8bYni3SdjOpjJ38wf7sAHZuTPaY+oQiGAbamXPYYREGsjjy5nx5b0eDps/W2Si6X/7y668PPmZ1ROsKC+71JOspb07Z1Q9doc/gwhu0y1Qsk+EQi9gihVw+Ia44up2sFbbUNnpEMQPiaun+ZOJJrfpzubSBbXcfMiIYwemRhN6nEpB1mPi+MRjgp8JyEyd7gFjirtbMp3ikvloUdTXcohYaIa/gPYubfzjRyQvrACclvy7hoh3wX4vAsunbhoyrGWK1oLxrAOTSyYuIR4XVGEjhjEUV3LnRWvN0ON8hLTrVT4LnI/F9xov27FOBRXk/YxH8kVKb1COMMji7aJCIpxNUT7Tyoz39d6p/V9KtlGqJbZisiKc/F/4vfFKT4dBTOSoxqdSZRVtQ9c2vpZpzqPAVbQ1rqAyAnrEG1aAIHAs6q+J2WC15F3/D2wsSIBzTRrBUzY6J3tI8s4eZtm31A/G0YbGDh5b6xjj0nUvJBRL5TUlzIOpntmBd32EQsLLEwUgeYwDqQnVzL0I0dL697N0PjRpky2EmC8JSecQuVZzceg2PDcXy0dpoXYE/1flrgczXO2ZeLmPGu9tA5vvhCdvtW8w24rBStysrpDhjk6CQgsEnQp57+9Nt4DnVIutlFo8NGr7bKA2gkG6JNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M/X396hl8ZAYoM27TkIzOjmj/83koEgCfKAn8iGAAQSzSQjNpZiDucKHoAdh?=
 =?us-ascii?Q?X0UdFNLx6alJx6rZwaAoAMELf094zUmN4ziqhAV/YWAf2U2dPtVmXbI4WX2C?=
 =?us-ascii?Q?XyAEHHMXyo4wS0l2Y57/lWsolRexaqIf98KtVrXmqnClTG0xf1J1HEZRq9DI?=
 =?us-ascii?Q?aL4RSCJlIf1rOimSRn3MCk/37CDCnh40Q3YnJtSIzSzajD023d/vRSFuwxzB?=
 =?us-ascii?Q?PoygIqNnXDg+0+0nwE/9aVYvjyCJy3q/kaUolufg0MG5/RXNaY9Relx5tuEG?=
 =?us-ascii?Q?2FqoHuGUL3OYVsZukjQ+4GJDXzWS4ougv8z+yRBsuGnoNdLYojwOk7DI7hVe?=
 =?us-ascii?Q?xHWSghxzFdMzjxFUv5wzTKsqfAyOextrV8IYyU1I5tuSmWwtyUGHA0dz57Sw?=
 =?us-ascii?Q?JogeTGOkV/MDsIj+Q2a8WOamIXacaOHmlEbgIXoalLCdsChsmZcAAHcehTUR?=
 =?us-ascii?Q?cRejRksCl1eP7ARd/XnUegrT31TWmvJooug+7aWfQRVbbLepPav8sX9ScrND?=
 =?us-ascii?Q?etVbGbii7CDw92ni+FsdffYtf6BLr76U0bdDwlJJknopwhPPqRQmeabXJ6eI?=
 =?us-ascii?Q?10gurHTLQCh7hwakws/OsuXQAwkYjK6tbEYklFbSUGoRNwJXdrwkcwnbyy0p?=
 =?us-ascii?Q?yl3UveboPw4ONnpM2skcGEynK8r8LwSbIDWm5Ax76xZFZ3ESYxJO3mCYNl3Q?=
 =?us-ascii?Q?WYx6ogxImLUhoJ/KpCHq18E/QHqO7IhWIX22fu24cquQ69YP/WjuH4UKorAW?=
 =?us-ascii?Q?iY+Tci+i7UgFbNCVVL/TmGwSVsrf9j56VkpLcvtl4hpfJO7YGNVsE+FbkXLG?=
 =?us-ascii?Q?hRV7oVxsKAr6rkObSmKY01kF5RfKm07KfM5ChK/a4IPp/MzYdzPubRdV3/np?=
 =?us-ascii?Q?03dr10XK1AxILSOT/dZpbBpot/r8Tknk/K5cMRVfbnjK2sf3odECm+pd2Qoj?=
 =?us-ascii?Q?P73v06bPqkaqQN4JDlwAzvxyO0yH2nt1OcFlYThILZvSw6hkmr2nYlBozxtW?=
 =?us-ascii?Q?A7dDSTchGtTU5Hb4g2SOyePHJyEtdyRMfk1QZLwoqLhh3Bzlln6cT1s0Drnd?=
 =?us-ascii?Q?b3fTIxPdRU1Y7VEcoIdfIByKSu9rktbPjF8BhMTiCNWyq/PCA+gCfzn1Olkv?=
 =?us-ascii?Q?yuEDehIic6TtpOPrwPVGPgynmGvCn3TbmjkY5n8o2mZqw8gnTbQbSuSKcMme?=
 =?us-ascii?Q?/jxslQ6cKrX6ez0X+uYMgEN8bWtMUXme+5/jUG1HJVb/pd1viwfPKfvm08xC?=
 =?us-ascii?Q?sA+LicMLtRis2TMcubeKF84hf2ZcKxK4zr7rt6hQ7DX/gbDCBIhnlZiKb1jb?=
 =?us-ascii?Q?QS6UepAtjL7OIfm+YjY7rtgN/cCLPZ3kZ6+Zv7yRwog1LG6zZUYcxsBUrMgm?=
 =?us-ascii?Q?jaz7W8RywElpnyZOFgNzUrcGKDcADg6gYf5NCnKUnihN2NqemIj+Bw/0EKeF?=
 =?us-ascii?Q?5W5xBW/TAAeSG61FfyTtiYbU/CGK0KwcMahGmkEAeEK1+zpGeBal3dDSAXq7?=
 =?us-ascii?Q?3TokjyyU4DlUR2vciQnj3dSccMWwITbj9yY7rnX098VqJg9UWTpZLtI8VeFz?=
 =?us-ascii?Q?/sSD7BwySbxtjlgEJwpjBmtcFHJOMjN8i7lLQxGh1wH7zIEVItaRteCNcBF2?=
 =?us-ascii?Q?gAHJf9gBN5eE427mz2Z7nB1APfegWpBO+SE75CQ7QhxPmhN/p7041aMlIuzh?=
 =?us-ascii?Q?TyEXkQ2pPKa/7DVpdCZDdhJokNvWZmwOcNyooZSHiGyzCph1TcTUjAMpmnyD?=
 =?us-ascii?Q?q8jrumqFLQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37748dc9-7342-4566-28ee-08de9d6364e2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 15:58:55.4266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwAXjN52J2SsLDY0eLZg0+ksKUTdfPMjfrcJ/wQs77tvFeSbsT92QT+a7x93dPYFVWZt7SQQHN//RV5nxlq8yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279515-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALLOW(0.00)[Nvidia.com:s=selector2];
	GREYLIST(0.00)[pass,meta];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64];
	NEURAL_SPAM(0.00)[0.747];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C3BB42184B
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Sat, Apr 18, 2026 at 04:41:12AM -0700, Weiming Shi wrote:
> vxlan_sock_add() tolerates IPv6 socket creation failure with
> -EAFNOSUPPORT (e.g. ipv6.disable=1), leaving vn6_sock as NULL while
> successfully creating vn4_sock. vxlan_igmp_join() and
> vxlan_igmp_leave() then crash when they dereference the NULL vn6_sock
> for VNI filter entries with IPv6 multicast groups:
> 
>  Oops: general protection fault, probably for non-canonical address
>       0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>  RIP: 0010:vxlan_igmp_join (drivers/net/vxlan/vxlan_multicast.c:40)
>  Call Trace:
>   vxlan_multicast_join (drivers/net/vxlan/vxlan_multicast.c:195)
>   vxlan_open (drivers/net/vxlan/vxlan_core.c:2965)
>   __dev_open (net/core/dev.c:1704)
>   __dev_change_flags (net/core/dev.c:9781)
>   do_setlink.isra.0 (net/core/rtnetlink.c:3180)
>   rtnl_newlink (net/core/rtnetlink.c:4238)
>   rtnetlink_rcv_msg (net/core/rtnetlink.c:6921)
> 
> Skip the IPv6 multicast join/leave when vn6_sock is NULL, consistent
> with how vxlan_sock_add() tolerates missing IPv6 support.
> 
> Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

AFAICT, this is the same patch as:

https://lore.kernel.org/netdev/20260323095544.3311285-4-bestswngs@gmail.com/

If you disagree with the feedback, then please comment there instead of
reposting the patch.

> ---
> v2:
>   - drop sock4 NULL checks 
> 
>  drivers/net/vxlan/vxlan_multicast.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
> index a7f2d67dc61b..e6aa5ab1c939 100644
> --- a/drivers/net/vxlan/vxlan_multicast.c
> +++ b/drivers/net/vxlan/vxlan_multicast.c
> @@ -37,6 +37,9 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
>  	} else {
>  		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
>  
> +		if (!sock6)
> +			return 0;
> +
>  		sk = sock6->sock->sk;
>  		lock_sock(sk);
>  		ret = ipv6_stub->ipv6_sock_mc_join(sk, ifindex,

This line changed in commit 29ae61b2fe7e ("drivers: net: drop ipv6_stub
usage and use direct function calls")

> @@ -71,6 +74,9 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union vxlan_addr *rip,
>  	} else {
>  		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
>  
> +		if (!sock6)
> +			return 0;
> +
>  		sk = sock6->sock->sk;
>  		lock_sock(sk);
>  		ret = ipv6_stub->ipv6_sock_mc_drop(sk, ifindex,
> -- 
> 2.43.0
> 

