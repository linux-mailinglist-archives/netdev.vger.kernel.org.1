Return-Path: <netdev+bounces-301641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3PHYBd7SO2oLdwgAu9opvQ
	(envelope-from <netdev+bounces-301641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:51:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB9A6BE479
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:51:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ON6ygssX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301641-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301641-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C4273023F86
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F687370AFB;
	Wed, 24 Jun 2026 12:51:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110F2E54D3;
	Wed, 24 Jun 2026 12:51:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305498; cv=none; b=ljxh35FyyWyXQQkT7suWMqjtMZnm7ECACyT4vKemuJ/emwTrqActxRA3W2p3NhrdWL95VRl16SfAtmACBly8rJdLu9S7sh5qqilEFkJwyeOVjoPEuxUwM84HAeK5kbS+1GqbfAEoQNVlqmLRZCuAIMk159YG8XeYCPRGZCfVoSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305498; c=relaxed/simple;
	bh=JygntB2Ne+3ZnglHYFvs0Go162WtvX+Sdc46OyaSRzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/IEMfuY9+aDAI6PE+rlixuOrqfn6wSC7Ir+Iifx+TjjmMzkbicuCm6C1XL8TAxP7K4hqEiWb1Ghu8sVUDsP4Q5Avf3BCtZQehQnCcpFh67uTc9+98v3/nKexlhVLFouzO3PANMRgNIE+wvs5Ix6Xn/7ieTI3TtElPiFQs9BXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON6ygssX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EFD1F000E9;
	Wed, 24 Jun 2026 12:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782305497;
	bh=w2+WSbuWj3Br0/KAK+7wZ21RrMqXPS2FwVJuuRa7QiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ON6ygssXOgNKZksSl4uMOYd1qwsq6crxZVz5+2UHZxVO+czY9zk8hYsuKi2EZyJxk
	 N1T4zuD6o2i6a3dif8Cpw40gYvF9WYq7V3m/D9F+XcAnrvuvjQ7YnyX2so3V30S4Y/
	 MtbOfW1zdgDxDdRyhYic8XPIef9T3itAvCGGwTNM1ORUwAXwitN64KPFJKt/0uO7NX
	 xSGPLm8LNunYfHmJL58nXaBHUAvGYA+uZAqQhnTjvGkfKzczeRCYmR6KeHMEXPvMsQ
	 AJE+WgZ5pijbBl9+aZwT1UlmbT4IOwGuLZGaXWo2nmE2pNOawccrTOPz1tDkkhRNZ2
	 JrmxQM4YF7aCA==
Date: Wed, 24 Jun 2026 13:51:32 +0100
From: Simon Horman <horms@kernel.org>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: tls: size splice_short pipe by page
 size
Message-ID: <20260624125132.GN827683@horms.kernel.org>
References: <20260622202847.3944076-1-nirmoyd@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622202847.3944076-1-nirmoyd@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301641-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nirmoyd@nvidia.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,queasysnail.net,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DB9A6BE479

On Mon, Jun 22, 2026 at 01:28:47PM -0700, Nirmoy Das wrote:
> splice_short grows its pipe with (MAX_FRAGS + 1) * 0x1000 so it can
> queue one short vmsplice() buffer for each fragment before draining the
> pipe. That assumes 4K pipe buffers.
> 
> On 64K-page kernels the request is rounded to 262144 bytes, which
> provides only four pipe buffers. The fifth one-byte vmsplice() blocks in
> pipe_wait_writable and the test times out before it reaches the TLS path.
> 
> Request enough bytes for the same number of pipe buffers using the
> runtime page size, and assert that the kernel granted at least that much.
> If an unprivileged run cannot raise the pipe above the system
> pipe-max-size limit, skip the test because it cannot exercise the
> intended path.
> 
> Fixes: 3667e9b442b9 ("selftests: tls: add test for short splice due to full skmsg")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>

The nit below not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  tools/testing/selftests/net/tls.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
> index 30a236b8e9f73..e3bf4ade0f770 100644
> --- a/tools/testing/selftests/net/tls.c
> +++ b/tools/testing/selftests/net/tls.c
> @@ -997,6 +997,8 @@ TEST_F(tls, splice_short)
>  	char sendbuf[0x100];
>  	char sendchar = 'S';
>  	int pipefds[2];
> +	int pipe_sz;
> +	int ret;
>  	int i;
>  
>  	sendchar_iov.iov_base = &sendchar;
> @@ -1005,7 +1007,12 @@ TEST_F(tls, splice_short)
>  	memset(sendbuf, 's', sizeof(sendbuf));
>  
>  	ASSERT_GE(pipe2(pipefds, O_NONBLOCK), 0);
> -	ASSERT_GE(fcntl(pipefds[0], F_SETPIPE_SZ, (MAX_FRAGS + 1) * 0x1000), 0);
> +	pipe_sz = (MAX_FRAGS + 1) * getpagesize();
> +	ret = fcntl(pipefds[0], F_SETPIPE_SZ, pipe_sz);
> +	if (ret < 0 && errno == EPERM)
> +		SKIP(return, "insufficient pipe capacity");
> +	ASSERT_GE(ret, 0);

nit: the line above seems redundant to me given the line below.

> +	ASSERT_GE(ret, pipe_sz);
>  
>  	for (i = 0; i < MAX_FRAGS; i++)
>  		ASSERT_GE(vmsplice(pipefds[1], &sendchar_iov, 1, 0), 0);
> -- 
> 2.43.0
> 

