Return-Path: <netdev+bounces-257031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNV8DTNOhGkE2gMAu9opvQ
	(envelope-from <netdev+bounces-257031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:00:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71937EFAB3
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8D4E301F9AF
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5935FF6F;
	Thu,  5 Feb 2026 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VYnp/j2N"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41035F8AC;
	Thu,  5 Feb 2026 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278273; cv=none; b=rBo7DqXJiSh/3TIWj7DpO0R9BLHvWpx4QTpktkNT5aTZnhh3e60w4t2VXNRlauRIGIqRBn6cDR3olw2IWPIUI1p8I2kq80U5o4vLMHESJ8FEC6eySOwvH2sAmmwDGLz7VBAGGPTq3gmG+mOonD/tmeaVCd7kupA+tD/S1gx73I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278273; c=relaxed/simple;
	bh=5gBYUTqFN5n46IwrLpvB0Kf7FBfEuyWbulp8PMfT3iQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnsmF3yNlRKy8BpMxuSKD7LyMHyrjJrW3zQFYJXgSV5Kj9XKMb0Pd/emFo5CnAu46vmy+lJh4uUFMAckReTBonPsQu1L3SJU2eaNKNWrV/w1aQW7GUmUyPoa44VPIhZcq4wjMXKQfJh0oTUzvZa0n6WnOMoIulsN1AZSFm1T1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VYnp/j2N; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id ACD6320842;
	Thu,  5 Feb 2026 08:57:43 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0kakHNcJO9sO; Thu,  5 Feb 2026 08:57:42 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C401D207FB;
	Thu,  5 Feb 2026 08:57:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C401D207FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1770278262;
	bh=EWQRaPO0KIa8FYypbTC/zhmdSAy1nGpvdhoGrTEl9F8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=VYnp/j2N68Ya8Ab0MCKK5uJ+C/HZVaUeju1/Cut3seH3BNy9E0YnXEzBMtYS7AJOE
	 cD4vUE4cvNSFjQ416qq2gL0uw/xJKNMpfmnx0ddM+gbX/MQE1QhG6PAhHiZtqr6E+g
	 ma5hswx3tKah2kV16gk1rLmPcgBxiBR7y6p/cmYeKYTAgvh2zop9Bi8nDdrvdfSlJX
	 Yu9WeSR14auiCP3+u5xFUodYlDAOrgYENKULE5iq4is7feHL8PYQ8C4dyFrYJFLlk8
	 DJPAltjgROhsLYOeSMM2wlPAF3VFYGBHr5vwN8Ps/VPGG30uiELmp7To0tsQwTO63I
	 DXQB2eRmY5x7A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Feb
 2026 08:57:41 +0100
Received: (nullmailer pid 856004 invoked by uid 1000);
	Thu, 05 Feb 2026 07:57:40 -0000
Date: Thu, 5 Feb 2026 08:57:40 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
CC: <netdev@vger.kernel.org>, Jiayuan Chen <jiayuan.chen@shopee.com>,
	<syzbot+e136d86d34b42399a8b1@syzkaller.appspotmail.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Patrick McHardy <kaber@trash.net>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v1] xfrm6: fix uninitialized saddr in
 xfrm6_get_saddr()
Message-ID: <aYRNdFs-_Zq4FPI-@secunet.com>
References: <20260127113845.219468-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260127113845.219468-1-jiayuan.chen@linux.dev>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257031-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,secunet.com:mid,secunet.com:dkim,shopee.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,e136d86d34b42399a8b1];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 71937EFAB3
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 07:38:44PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> xfrm6_get_saddr() does not check the return value of
> ipv6_dev_get_saddr(). When ipv6_dev_get_saddr() fails to find a suitable
> source address (returns -EADDRNOTAVAIL), saddr->in6 is left
> uninitialized, but xfrm6_get_saddr() still returns 0 (success).
> 
> This causes the caller xfrm_tmpl_resolve_one() to use the uninitialized
> address in xfrm_state_find(), triggering KMSAN warning:
> 
> =====================================================
> BUG: KMSAN: uninit-value in xfrm_state_find+0x2424/0xa940
>  xfrm_state_find+0x2424/0xa940
>  xfrm_resolve_and_create_bundle+0x906/0x5a20
>  xfrm_lookup_with_ifid+0xcc0/0x3770
>  xfrm_lookup_route+0x63/0x2b0
>  ip_route_output_flow+0x1ce/0x270
>  udp_sendmsg+0x2ce1/0x3400
>  inet_sendmsg+0x1ef/0x2a0
>  __sock_sendmsg+0x278/0x3d0
>  __sys_sendto+0x593/0x720
>  __x64_sys_sendto+0x130/0x200
>  x64_sys_call+0x332b/0x3e70
>  do_syscall_64+0xd3/0xf80
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Local variable tmp.i.i created at:
>  xfrm_resolve_and_create_bundle+0x3e3/0x5a20
>  xfrm_lookup_with_ifid+0xcc0/0x3770
> =====================================================
> 
> Fix by checking the return value of ipv6_dev_get_saddr() and propagating
> the error.
> 
> Fixes: a1e59abf8249 ("[XFRM]: Fix wildcard as tunnel source")
> Reported-by: syzbot+e136d86d34b42399a8b1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68bf1024.a70a0220.7a912.02c2.GAE@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Applied, thanks a lot!

