Return-Path: <netdev+bounces-268379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKXLN7auuGmHhgEAu9opvQ
	(envelope-from <netdev+bounces-268379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:30:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8939F2A28C3
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E529300C922
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CB8336EDB;
	Tue, 17 Mar 2026 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj+JTxn3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ACE334C36;
	Tue, 17 Mar 2026 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773711025; cv=none; b=CY2WYKz/uiJz1ix5G7MmOpJcXsg6aR3ie2xKrPeLAtHitpxMjIKmqNL4WNpUI5O3Ctz/mqkXNDEpAXos/DuNJezajP3Ht+7ZX6DYR1OJpJyCHpZdfjgIwwGx1tMwlgSx2S8W2io9Z0TEQrlWY7AjHd2ErU7yfJV88kPWltcbUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773711025; c=relaxed/simple;
	bh=SdQjhpTTh5WGPKXIxvzSg6w2BvmVngtK/VAR60k24Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8dl1ydtE+njGSfOP9Kr9m1q1GrLa+Ne6nmv7IP7nDUn38r/4XcEWpLlCpIxVePQFVTBbhuJMkOe6blVXEHXCr7N5ofqj1WUv/wB4qRlBixlxa2X46rX79A5A3yXgy6vZoR5RgQwxgY1vcKEwrZlKcqmfX5xABIbPSl+93xFgXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zj+JTxn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE141C19421;
	Tue, 17 Mar 2026 01:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773711025;
	bh=SdQjhpTTh5WGPKXIxvzSg6w2BvmVngtK/VAR60k24Dw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zj+JTxn35P2MFXxHVPKETnzHP1cbpN5lZM9xZGHcjNMSoAfbu+zB5vCLTUmZugH9A
	 xGEvy5KjItc4fFDGHrjlHOlW+i39H9q3vKn+n3V5BMiFoPyDFJUUv60VJvnxF0PcRQ
	 ptSE103Tdq/608di6K2D8SqfiqfNdCJaiIAVoQ/Hn6y0cwXLe94T6BHV/hdUnhSk4X
	 0tVkNSUD+8XLARYTO2sROoQkGgi09BRLlhd4n3AGjgdp4nwnIrW3mszEh4VEZqjh3y
	 Sqs5HiVQZYG6SbpqeXrMjw5I9wUu1ARPTSwbVgRcd4E/WK56GD4ODYk+/aJwEjDR/A
	 O3ikQhe7wQoaQ==
Date: Mon, 16 Mar 2026 18:30:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "dlemoal@kernel.org"
 <dlemoal@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sd@queasysnail.net"
 <sd@queasysnail.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Alistair Francis
 <Alistair.Francis@wdc.com>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
 <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Message-ID: <20260316183023.2fb38d84@kernel.org>
In-Reply-To: <8f29d43fc1fd7e6feec4c24131eb2c0292a8c0fd.camel@wdc.com>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
	<20260309054837.2299732-3-wilfred.opensource@gmail.com>
	<abQOGm6BqAE5eEln@krikkit>
	<20260314073919.2f92b966@kernel.org>
	<9e9f6eb89ba95e9fbb764e2807420e98b566bf37.camel@wdc.com>
	<20260316180355.37d45785@kernel.org>
	<8f29d43fc1fd7e6feec4c24131eb2c0292a8c0fd.camel@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lwn.net,kernel.org,davemloft.net,vger.kernel.org,gmail.com,queasysnail.net,wdc.com,redhat.com,linuxfoundation.org,google.com];
	TAGGED_FROM(0.00)[bounces-268379-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8939F2A28C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 01:21:12 +0000 Wilfred Mallawa wrote:
> On Mon, 2026-03-16 at 18:03 -0700, Jakub Kicinski wrote:
> > On Tue, 17 Mar 2026 00:53:07 +0000 Wilfred Mallawa wrote:  
>  [...]  
> > > 
> > > For upcoming WD hardware, we were planning on informing users to
> > > use
> > > this feature if an extra layer of security can benefit their
> > > particular
> > > configuration. But to answer your question, I think this falls more
> > > into the "checking a box"...
> > > 
> > > I'm happy to drop this series if there's not much added value from
> > > having this as an available option for users.  
> > 
> > I'm not much of a security person, and maybe Sabrina will disagree
> > but I feel like it's going to be hard for us to design this feature
> > in a sensible way if we don't know at least one potential attack :S  
> 
> Traffic analysis is the attack vector we are trying to mitigate against
> with zero padding, which TLS is susceptible to [1]. I think the hard
> part is deciding the padding policy and balancing it such that we have
> sensible performance.
> 
> This series adds random padding to records with room, a stronger policy
> I think would be to pad all records to max record size length. But that
> adds a much higher performance overhead. For context, when testing NVMe
> TCP+TLS with 4K writes with a record size limit of 4k, we observed a
> 50% reduction in IOPs on the fixed max record pad policy as opposed to
> the random padding policy from this series.

Sorry, I realized when i hit "send" that I phrased my previous message
poorly. When I say "potential" I mean someone actually presenting a PoC
and a CVE is issued for it. Have we seen any of those?

