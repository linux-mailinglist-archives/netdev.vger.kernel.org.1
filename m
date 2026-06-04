Return-Path: <netdev+bounces-295398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id keTLDePNIWoGOQEAu9opvQ
	(envelope-from <netdev+bounces-295398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:11:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A687D642D0D
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:11:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=McR7Q8GS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295398-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295398-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52457304AAB9
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 19:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301B37DAAE;
	Thu,  4 Jun 2026 19:10:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0D36EA8F;
	Thu,  4 Jun 2026 19:10:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600211; cv=none; b=bqaHwubGZ4o5u+iIxMzOvAJ5qzwFOyGrShrfXn1TXCyoJC689WS4zqoGncKcEHJYwTULBCekeDfawMsBgkPQFUkRXnRB/R5JuK4IjN2tr9qFqcia4OdfDSPIkl6nRZfn+i8iaqFBI5apeNLXGQSGfuTRkC2ilhbWY8Ph6bZWRBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600211; c=relaxed/simple;
	bh=cJbiz4iTiI0j8fChRZ0wieWBv7v7rrH41XMrZGkM6eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnQplnIM0v/262w3Zpu+eJXxGrhejOCiOFwymv0D/1NTQSYwHQio/W2wVoZoFwnm9l1BcBfeOQUo0QMfOVqgg6FDcoxoN3PTOHyBbyKVO+foae43iH5IhmKi6zrM0EnrFsafkeu4UzutFSlJs+OvYi8x40mKNSNbapWluRdFOgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McR7Q8GS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41041F00893;
	Thu,  4 Jun 2026 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780600210;
	bh=3JXJ9ZLuO/U/95Uxyjn8hhGBG4k4Mm6+meEdoexQuUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=McR7Q8GSjDRQDw8p0cxBWnbTNJzN2u5axSN1As+aCL2TsIGoyX1nIHvcrnIOLOdU3
	 mrQHYHYEAbeQAfJDf5IQaBNeHyzdtwBSUgE7yzmNYF9TjGC5KINRHVs7yi3rfd7nnV
	 eOGFIGD/16kdo5rfRFiMiUr1epz4FrZ49N49Z4MP5yV5DrJBUGKPtF3J7jngjHwS5o
	 iRfME4GxKzSyT47qgY6tE39aIkDXcKWiU/sdU68r9O6GUdCChAx0KJWG3p9okaPQvs
	 YNyGPZqS491iXrtdHKLX5r5AWmRgCGFajwItKz2cANTMvU4Q5mgHnYOn2gKgU7HVaz
	 +57cQjs/i7iwg==
Date: Thu, 4 Jun 2026 20:10:05 +0100
From: Simon Horman <horms@kernel.org>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] net: reduce RFS/ARFS flow updates by
 checking LLC affinity
Message-ID: <20260604191005.GG3920875@horms.kernel.org>
References: <20260602115323.3502-1-nashuiliang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602115323.3502-1-nashuiliang@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295398-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nashuiliang@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sdf.kernel@gmail.com,m:kuniyu@google.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:ncardwell@google.com,m:shakeel.butt@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A687D642D0D

On Tue, Jun 02, 2026 at 07:53:10PM +0800, Chuang Wang wrote:
> The current implementation of rps_record_sock_flow() updates the flow
> table every time a socket is processed on a different CPU. In high-load
> scenarios, especially with Accelerated RFS (ARFS), this triggers
> frequent flow steering updates via ndo_rx_flow_steer.
> 
> For drivers like mlx5 that implement hardware flow steering, these
> constant updates lead to significant contention on internal driver locks
> (e.g., arfs_lock). This contention often becomes a performance
> bottleneck that outweighs the steering benefits.
> 
> This patch introduces a cache-aware update strategy: the flow record is
> only updated if the flow migrates across Last Level Cache (LLC)
> boundaries. This minimizes expensive hardware reconfigurations while
> preserving cache locality for the application. A new sysctl,
> net.core.rps_feat_llc_affinity, is added to toggle this feature.
> 
> Additionally, export sock_rps_record_flow_hash() and
> sock_rps_record_flow(). This resolves a symbol visibility compilation
> error triggered by 'tun' using sock_rps_record_flow_hash() in
> tun_flow_update() when CONFIG_TUN is built as a module. The same logic
> is applied to SCTP, allowing it to use sock_rps_record_flow() safely
> when built as a module.
> 
> Performance Test Results:
> The patch was tested in a K8s environment (AMD CPU 128*2, 16-core Pod
> with CPU pinning, mlx5 NIC) using brpc[1] echo_server and rpc_press.
> 
> rpc_press Commands:
> 
>   for i in {1..8}; do
>     ./rpc_press -proto=./echo.proto -method=example.EchoService.Echo
>     -server=<IP>:8000 -input='{"message":"hello"}'
>     -qps=0 -thread_num=512 -connection_type=pooled &
>   done
> 
> Monitor mlx5e_rx_flow_steer frequency:
> 
>   /usr/share/bcc/tools/funccount -i 1 mlx5e_rx_flow_steer
> 
> Frequency of mlx5e_rx_flow_steer (via funccount[2]):
> 
>   Before: ~335,000 counts/sec
>   After:   ~23,000 counts/sec (reduced by ~93%)
> 
> System Metrics (after enabling rps_feat_llc_affinity):
> 
>   CPU Utilization: 38% -> 32%
>   CPU PSI (Pressure Stall Information): 20% -> 10%
> 
> These results demonstrate that filtering updates by LLC affinity
> significantly reduces driver lock contention and improves overall
> CPU efficiency under heavy network load.
> 
> [1] https://github.com/apache/brpc/
> [2] https://github.com/iovisor/bcc/blob/master/tools/funccount.py
> 
> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>

Hi,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/

I would appreciate it if you could look over that with a view
to addressing any issues that directly effect this patch-set.

