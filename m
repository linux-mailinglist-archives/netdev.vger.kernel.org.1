Return-Path: <netdev+bounces-191690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359F0ABCC65
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 03:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC41F169AB7
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 01:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2771221E0BB;
	Tue, 20 May 2025 01:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="AWCQ6qeR";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="gYotsU7H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845A4B1E5C
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747705080; cv=none; b=OJysoZfU3wp+qhtnpfuaNBEZ65yuiG/YE4Ep2d+bHkCbt6F9js6/2jFo2KQ6Gu7Tqe6S/tr3jvJtN8ElX3FuiboxHQlaTM88N2mic0t/GXXgqOFJQDRWL1XV1Kux+tDn7GY4zTeYfRnwxlB0lb4Bwh6oQ+IpSE+3xouGz2WkCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747705080; c=relaxed/simple;
	bh=XA/vMCVpIfjTJXCkcJsC1zRWpAp1PCVcgULIjiaoTas=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dpylDmcHA5YgrNnOKAPdl/96AgAlQuQv1ZpYwR9DT7cQcgGqbHOmlh7BaeC90cevb6sqMJ5W0bWHxaxxsR+VSG1yAq6Bn5XU72qN90NJoXZ6uuuZcTcmUP5AmGGdXAe0RvIZnJdYi2ufzm6jprn11VsK5o+NcLXDJo61m4gjLiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=AWCQ6qeR; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=gYotsU7H; arc=none smtp.client-ip=160.80.4.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 54K1bAAh032447;
	Tue, 20 May 2025 03:37:15 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 8F70B1205C5;
	Tue, 20 May 2025 03:37:05 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1747705025; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4xRU2ratrj+rHIVvF1jAVQWZqX+Qdn2Xh9r/t/No4f4=;
	b=AWCQ6qeRkqBpguPdx3QGFrtD6ahu4x1heoOkY9MBZJgPBTAi8YXuvN7bxY8+TG2yYIdrKv
	c6EGNMOjs9ONy7CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1747705025; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4xRU2ratrj+rHIVvF1jAVQWZqX+Qdn2Xh9r/t/No4f4=;
	b=gYotsU7H79/FhSCvBATTLL1xyp2pjkornfCLnIHOjH8TgRQvVsbZrBYAjoWxTGdTUKtl5w
	hqAE0lCpJyIRZy/mrcIIbZB6BjcqmamcmozPyMfqlqlUwWgRO0dEPi5CuY6UaQY7KiiIl/
	28DSn3cLZlfgpJfGhGVE7G3dZeqW56HeLUmJuS4/gXk8YqA8RyTFH+JqExTwKmF0/DSQYX
	Z/pRFBC2Tz1XsleRV6vFIx+BfWaEbh9Ad4wGM0OKae3Ry6PrJpmH3C6y5LiH5oC9ufWQd7
	VBozCI/Dy+CHQQD1lV14IUR5qKe7JtE0ANL+hMOlaWQ4dHL2qbpeKsSwNla+lQ==
Date: Tue, 20 May 2025 03:37:05 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH v2 net-next 4/7] Revert
 "ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during seg6local LWT setup"
Message-Id: <20250520033705.662cb221ec3e55a4ad08736a@uniroma2.it>
In-Reply-To: <20250516022759.44392-5-kuniyu@amazon.com>
References: <20250516022759.44392-1-kuniyu@amazon.com>
	<20250516022759.44392-5-kuniyu@amazon.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Thu, 15 May 2025 19:27:20 -0700
Kuniyuki Iwashima <kuniyu@amazon.com> wrote:

> The previous patch fixed the same issue mentioned in
> commit 14a0087e7236 ("ipv6: sr: switch to GFP_ATOMIC
> flag to allocate memory during seg6local LWT setup").
> 
> Let's revert it.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv6/seg6_local.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Patch [1] was originally intended to fix the creation of seg6local lwtunnels
within an RCU-protected block executed from inet6_rtm_newroute(), where recent
changes to locking mechanisms were introduced.

Patch [2], included in this patchset, aims to redesign and correct the RCU
usage in inet6_rtm_newroute().
From the perspective of the SRv6 subsystem, the creation of a seg6local
lwtunnel is no longer performed within an RCU-protected section. This change
allows us to sleep again and enables memory allocations with GFP_KERNEL, which
is clearly preferable.

After applying this patch (along with the corresponding patchset), it appears
that creating a seg6local lwtunnel instance works fine.

Therefore, I believe it is ok to revert [1] in favor of the current approach.

Thanks,
Andrea

[1] ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during seg6local LWT setup
    https://patch.msgid.link/20250429132453.31605-1-andrea.mayer@uniroma2.it

[2] ipv6: Narrow down RCU critical section in inet6_rtm_newroute()
    https://lore.kernel.org/all/20250516022759.44392-4-kuniyu@amazon.com/


Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>


> 
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index ee5e448cc7a8..ac1dbd492c22 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -1671,7 +1671,7 @@ static int parse_nla_srh(struct nlattr **attrs, struct seg6_local_lwt *slwt,
>  	if (!seg6_validate_srh(srh, len, false))
>  		return -EINVAL;
>  
> -	slwt->srh = kmemdup(srh, len, GFP_ATOMIC);
> +	slwt->srh = kmemdup(srh, len, GFP_KERNEL);
>  	if (!slwt->srh)
>  		return -ENOMEM;
>  
> @@ -1911,7 +1911,7 @@ static int parse_nla_bpf(struct nlattr **attrs, struct seg6_local_lwt *slwt,
>  	if (!tb[SEG6_LOCAL_BPF_PROG] || !tb[SEG6_LOCAL_BPF_PROG_NAME])
>  		return -EINVAL;
>  
> -	slwt->bpf.name = nla_memdup(tb[SEG6_LOCAL_BPF_PROG_NAME], GFP_ATOMIC);
> +	slwt->bpf.name = nla_memdup(tb[SEG6_LOCAL_BPF_PROG_NAME], GFP_KERNEL);
>  	if (!slwt->bpf.name)
>  		return -ENOMEM;
>  
> @@ -1994,7 +1994,7 @@ static int parse_nla_counters(struct nlattr **attrs,
>  		return -EINVAL;
>  
>  	/* counters are always zero initialized */
> -	pcounters = seg6_local_alloc_pcpu_counters(GFP_ATOMIC);
> +	pcounters = seg6_local_alloc_pcpu_counters(GFP_KERNEL);
>  	if (!pcounters)
>  		return -ENOMEM;
>  
> -- 
> 2.49.0

