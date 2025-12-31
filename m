Return-Path: <netdev+bounces-246443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D468FCEC366
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 17:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5266F3007191
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF7E2701D1;
	Wed, 31 Dec 2025 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="0sOqNwNZ"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster2-host12-snip4-8.eps.apple.com [57.103.78.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F051547EE
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767197228; cv=none; b=XYLyk1MEu4VUsHwvpeyM+AAFlkbLAKztDnml5c0h+cVqHFJoCtGwfEXShBnFw2LsoRy6p6E8NrpZoaRK4/7jK8r2szwqY9k1NBAGWEl9ldKX7BPwwjIlLOn0HYktFQAgWZd9QZUOwm3lYBmAmLHjvYXRj5x7zPnbCSO+Yi4eJDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767197228; c=relaxed/simple;
	bh=0JVXy2gwJTVwEVVlEQ5jZj98Ua9gSKA/Gc+afc8wBf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRPmu8AaJKN+yEJ3f2bYB0gfzbwVZsHCm4qBQp9xs/MVx/bPIx9RVT+tmZyN9mzDcCl94Fpk5GQO1TP29PHL+BFFXxQv2MmERr0RL/YE9X09urRM4muAZkpU6yunuEgr2pzUB7ecGbI3uaIXousDDS4/wdVfK1j+7On7HxPBGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=0sOqNwNZ reason="key not found in DNS"; arc=none smtp.client-ip=57.103.78.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id 230531800303;
	Wed, 31 Dec 2025 16:07:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=FnxT6ofpnpa3D+FRgAoLQu+CKxc/yMPkGpPebPRzSE8=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=0sOqNwNZvnGcqTApxEdzinvDC/K7XgnTUmEZlMa+EhJYf5mu1/CSBtwXAE3RloQN6JoSfGe53ADUSnaFB46iGEERcIRP4BxPK7eAItenvrz7GysKaw9Iz9Ri2CCmVwyCnZj0AaLaI9uWcf9BgosPoJ73nbVReiP6OvyxOxr+xInB/pLc54rr4l1onNosVdHuItbAIwQtxsJ3XJf/B8B+J6Y7Ux0fLjt6WqHvGQEfPaGmaBZxjGZhmmvp9yt5NR/1kP2iFoQIhO1wcgrdifssW1aKpv2Q7Bk9wv5AYKocHcA7WNxdsVikVji8HEaCeADubeaiT9Fmj+PM3+1XfEHT3g==
mail-alias-created-date: 1719758601013
Received: from desktop.homenetwork (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id 49661180016B;
	Wed, 31 Dec 2025 16:06:59 +0000 (UTC)
Date: Thu, 1 Jan 2026 01:06:56 +0900
From: Yohei Kojima <yk@y-koj.net>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: netdevsim: fix inconsistent carrier
 state after link/unlink
Message-ID: <aVVKICvpimILHy5s@desktop.homenetwork>
References: <cover.1767108538.git.yk@y-koj.net>
 <c1a057c1586b1ec11875b3014cdf6196ffb2c62b.1767108538.git.yk@y-koj.net>
 <4xxshlplnoulncmfkinnuzvwx7bbnukkwds7go75cese4scrws@6xlfsy35t7gg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4xxshlplnoulncmfkinnuzvwx7bbnukkwds7go75cese4scrws@6xlfsy35t7gg>
X-Proofpoint-ORIG-GUID: nLISmvHcFDC5WwTRfZtJnPYsiGZHQ63P
X-Proofpoint-GUID: nLISmvHcFDC5WwTRfZtJnPYsiGZHQ63P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDE0MSBTYWx0ZWRfXyBQPWPkOHIe/
 13PUJrvqNTyRNgOqRdEb5fCgKhF5/gYikPn3giuQbfQagP1BljP7S2/oT26QBnjd4p28T4jZd/L
 +sHBqYXkRPqkIDcB1CgyIHDXf36TN54L7+U9CgEcZ8IG3121EFJ0Koc+OEJ/ZGKTJCRObcdo9gk
 PQ0mphKRu42HQYTRE47yi9k+9CqahAszgt+3d6/YyOp+7LaoOv7H0z5kgqtPAbww3N1IkRZKP64
 k4ygdoP8tATYOaou7dLbIRwEJTLy7Afoowk3SIWwLab3We3Hbbn6d/+jtrYWkDDRgP23qgGDCPb
 EHtrUpxJ7WUrLYCVfAx
X-Authority-Info: v=2.4 cv=S7XUAYsP c=1 sm=1 tr=0 ts=69554a27 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jnl5ZKOAAAAA:8 a=xNf9USuDAAAA:8 a=QPRiRnIaLoA074YFEDcA:9 a=CjuIK1q_8ugA:10
 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 mlxlogscore=651 spamscore=0 suspectscore=0 clxscore=1030
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512310141
X-JNJ: AAAAAAAB0tCeAz+8Yd6KVsmlQVO1REb8PfDA8BzAu4AVpajvuMRFM0ovlaYLFxoeATrtKCUINZu3c2+JOctrWqQrKb6Z69caE/KB/hciWGcY54bL6iiagAJoBO79/WJzSSqWH5D27YWGJ7ws0DRqtNMi0GG5SSK3nf/NWFvi0q6FHksVhVxFWPWTgAVwW+9EsApKzccLTUSnvdMUSoaqk034RFHpN1Jxzb3DIaGylt7L5wmAao25QpILhMtxcasX/Nenh6MkG8OplS6IUAvq1NEZJdwG0rubzEfyiFFWuxMXePFdA0wgoOOM2XHc7lp2CZQ2KIKLl8U07px+l3AzW1RlKPsn62x4HhMNJCYDL7A1mVJM3TSC9ijqwDsPY2ATL99Uko2YhmwHcgfFsWRUq2YGx0sPlYaiFtoFwz3OJY8IgHkmycqqC8SnFI3bUvHnGupEbFqJKrvZhO5jwqAmE9jgeLCtPCscM/Y4Ak81HV7W9uJgCpE2xC9U4yd/AsEyDTKTpjCwyYMb//7rNcHTcNwggnR0eEWvQ0UZAiHFoRn7xC0+2dybbviuC2Di3oxk5ldixVRIZBu7/IGxh77bXLm8rc7AP6wyyETd/P1SFc0lEue2u2dNNkB6tOKTGFOGtUWy2WdErPyxUd9c7ZJBu5mPWX1S/3ZKs8CHs9Pt+JavMr7fv00PvKkQ0ucDHUA2Kob4TbzRZkaPFN3wGlRJp/xVpPAq5Qc1H1crRT8=

On Wed, Dec 31, 2025 at 02:16:53AM -0800, Breno Leitao wrote:
> Hello Yohei,
> 
> On Wed, Dec 31, 2025 at 01:03:29AM +0900, yk@y-koj.net wrote:
> > From: Yohei Kojima <yk@y-koj.net>
> > 
> > This patch fixes the edge case behavior on ifup/ifdown and
> > linking/unlinking two netdevsim interfaces:
> > 
> > 1. unlink two interfaces netdevsim1 and netdevsim2
> > 2. ifdown netdevsim1
> > 3. ifup netdevsim1
> > 4. link two interfaces netdevsim1 and netdevsim2
> 
> > 5. (Now two interfaces are linked in terms of netdevsim peer, but
> >     carrier state of the two interfaces remains DOWN.)
> 
> That seems a real issue, in fact. The carriers are only getting up when
> opening the device, not when linking. Thus, this patch makes sense to
> me.
> 
> > This inconsistent behavior is caused by the current implementation,
> > which only cares about the "link, then ifup" order, not "ifup, then
> > link" order. This patch fixes the inconsistency by calling
> > netif_carrier_on() when two netdevsim interfaces are linked.
> > 
> > This patch fixes buggy behavior on NetworkManager-based systems which
> > causes the netdevsim test to fail with the following error:
> > 
> >   # timeout set to 600
> >   # selftests: drivers/net/netdevsim: peer.sh
> >   # 2025/12/25 00:54:03 socat[9115] W address is opened in read-write mode but only supports read-only
> >   # 2025/12/25 00:56:17 socat[9115] W connect(7, AF=2 192.168.1.1:1234, 16): Connection timed out
> >   # 2025/12/25 00:56:17 socat[9115] E TCP:192.168.1.1:1234: Connection timed out
> >   # expected 3 bytes, got 0
> >   # 2025/12/25 00:56:17 socat[9109] W exiting on signal 15
> >   not ok 13 selftests: drivers/net/netdevsim: peer.sh # exit=1
> > 
> > This patch also solves timeout on TCP Fast Open (TFO) test in
> > NetworkManager-based systems because it also depends on netdevsim's
> > carrier consistency.
> > 
> > Fixes: 1a8fed52f7be ("netdevsim: set the carrier when the device goes up")
> > Signed-off-by: Yohei Kojima <yk@y-koj.net>
> 
> Reviewed-by: Breno Leitao <leitao@debian.org>

Thank you for the review!  

> 
> Thanks for the fix!

When I encountered this bug, I could easily identify where to fix thanks
to your previous commit. Thanks again for your support!

Best regards,
Yohei Kojima

