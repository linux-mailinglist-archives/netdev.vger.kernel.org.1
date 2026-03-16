Return-Path: <netdev+bounces-268115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO5HM3nht2lDWwEAu9opvQ
	(envelope-from <netdev+bounces-268115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:54:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 334EA2984E1
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CF60303C03E
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C94738F932;
	Mon, 16 Mar 2026 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeI7MHvV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A2438F647;
	Mon, 16 Mar 2026 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658238; cv=none; b=hL5pjcnasASOZrzHGxUTC61sFITLw2sFsoJ6oLLpgZhI7DIfRqVVZHxy5cXUEnKvkHHpxteRnr9bzQ+8ElKqNThX0uYolT4ZHpmr5hWqNlTwPzorL6mvxr0XKLl4Rs0SDbYzYPet8nZ5+6XZKW9PQfRCzkQ4as/JUv7GH1rZXtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658238; c=relaxed/simple;
	bh=BZzPB4RGiBjoObZCPldSipYUuHfqzEsnClur7CKQhQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6qe+vgWKFdfD1NCN5hTnFKGv6/TipnF7mRx75lqBv8lgKG05bV2kYx6pfaXH8vvCRGclzPxnE9sE/EKVPa3MbxhCNc0SiiQHrURYCMZxD4MR3i6cL5F0o4W28ypLXXijJ60EwybMnarvVzyKoO6wwW8exboTDAYf9gARZQhTy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeI7MHvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE85C19424;
	Mon, 16 Mar 2026 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773658237;
	bh=BZzPB4RGiBjoObZCPldSipYUuHfqzEsnClur7CKQhQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MeI7MHvVfgUY1ZES4MJjGrlm0yTKHWa/yVoomllr/yfW4agEPwm8UVyvhuK7vvhex
	 ljgzsO61tNMdfuPdKQqPYjH8QQnKzaGgJYIhew0V3NZt+T2XgNNGlVXVtizodPlPJq
	 yKzJsBNIhDXvjYcUROAe8OJXd2EuHJOuqBu876K0NVMhoNAHs3Giwucuy6kvlVobjd
	 8LDer2p2GUfdzPA4zOvU1FCh0gjND4b6MkvbBJZBAYQZy/i5zbYHAfwAhlAzxNfH0r
	 ULLbdMgh0SQ3K09/RwvH1uiS5DuSLrmYZmeZLqSkVzxknPXNDcPZ9BmB66bI8Io6mM
	 6UCWNiMsqUlrQ==
Date: Mon, 16 Mar 2026 10:50:33 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, dsahern@kernel.org
Subject: Re: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and
 remove stubs
Message-ID: <7a5a442e-aa0d-4d01-b27c-c4479d53df06@lucifer.local>
References: <20260309022013.5199-1-fmancera@suse.de>
 <48ccec3f-dbc8-45c8-afda-e4f7e8f150d6@kernel.org>
 <cd87ed46-b774-4896-b25e-4806eec9e0b3@suse.de>
 <6c005900-3461-4e3c-a396-b2984735af9b@kernel.org>
 <51102620-fb8a-467e-9144-786d1fe27e31@iogearbox.net>
 <4e3cd289-2b7a-4f64-99f6-05eb9d67c0fc@kernel.org>
 <c28d7cba-3805-4e6d-8051-d12e923c1973@lucifer.local>
 <a1dc7907-39a0-4417-8589-c48a4a7cc839@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1dc7907-39a0-4417-8589-c48a4a7cc839@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268115-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 334EA2984E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 11:33:33AM +0100, Krzysztof Kozlowski wrote:
> On 16/03/2026 11:24, Lorenzo Stoakes (Oracle) wrote:
> > On Mon, Mar 09, 2026 at 02:02:45PM +0100, Krzysztof Kozlowski wrote:
> >>> Are you talking about [0]? That's legacy hardware and in this case just
> >>
> >> Dunno what is legacy there...
> >>
> >
> > Is this satire?
> >
> > I'm not sure why you're being quite so aggressive in your response overall
> > here, but Amiga is ABSOLUTELY legacy and you are delusional if you think
> > otherwise?
> >
> > I think the kernel should absolutely drop support for it, museum pieces
> > like this cause undue maintenance burden, and sorry not sorry - if you own
> > hardware that old, live with using older kernels.
> >
> > In any case this kind of facecious engagement, especially in response to
> > somebody as lovely as Fernando, is really unhelpful.
>
> Response was to Daniel. You come late to the thread, pick up one thing
> and poke... great.

I call out unpleasant/bullying behaviour when I see it, and I'm not going
to apologise for that, especially when it comes from an experienced
maintainer.

And sure, s/Fernando/Daniel/, but I'm not sure that's the
incredible riposte you seem to think it is.

I'm not going to belabour the point, being civil to people when they are
not being unreasonable should be a default, it's sad that it's not always
the case in the kernel.

>
> >
> > If I'm wrong and somehow Amiga isn't legacy in 2026, then SAY SO instead of
> > giving an unnecessarily mean, dismissive and frankly embarassing response
> > like the above.
>
> Calling something legacy in this thread is not really appropriate
> because it is diminishing its important or requirements.
>
> Till we support given hardware, we are supposed to consider its
> requirements. If you do not consider these requirements, then you do not
> consider that hardware as worth being supported and this means you
> should first propose patch to remove that hardware.
>
> If you do not want to care about that hardware, don't use arguments
> "legacy" in discussions, but simply drop it. We do such with "legacy"
> architectures.

Perhaps you could have replied with this instead of rudely making the
ludicrious claim that Amiga isn't legacy in 2026?

>
> Best regards,
> Krzysztof

Thanks, Lorenzo

