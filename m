Return-Path: <netdev+bounces-216176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411EDB3258C
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 02:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4052AE1F33
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 00:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7551B1367;
	Sat, 23 Aug 2025 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDqkb652"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5087E10FD
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755907709; cv=none; b=DMJ2ky5dZmO53SxN6RPEYlXj6f/k6hY2CFVvH0OEwyYrHpAdIHUBxcA2pmxvuPtIv49C8TiBpFwawXnr+h8dENLVqih2bLRbdnNRKaJiLpwST6lB6iPSQTO2KM5H6ZoY9iJblUi+N1FGS6HQu+MTbuls+iZL2VUCBoPLYrpvo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755907709; c=relaxed/simple;
	bh=vayFt+Q5xAO2WuHi8U9aALQVNz06J+uPlvzBWQcKjFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEFZHaJNeV3GjSqgIP8Km/BdOL7tNHQ73LWXsqiD7pX/e5BzkAXzNLietmx9lmBASQ0b6saaDedsa9a329Wo9GqFVYFTR6j1XFXmRpcGiW09UZA6X8rOvaDSKfjEePaFRIHO7tkwbtBO0UOU+EeEvxDNN01NQc/8rL9J5Hg0DUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDqkb652; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5935DC4CEED;
	Sat, 23 Aug 2025 00:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755907708;
	bh=vayFt+Q5xAO2WuHi8U9aALQVNz06J+uPlvzBWQcKjFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iDqkb652jjkATcfOkV8OHbJNUZXfTpjYackbKdc79TArshkOYBrFcWvNenjVcQNa1
	 djZfOhQxNZz0RZwkSH2lE3BMT/xG7e+54dYEtTUDjcoynvaXpb6ZAbkJAhJzVmEHPV
	 0/qk8J6TiwcagqE+t+cCvoCdRezrQMN59QbYr6doMSgCcFouJo1zvbaWw7n+ngMq7Y
	 7YY0jqQ8C37br7ZdWEiFtvUauWsWQlubsI0S6poEr+sEM7hA8/G5DPUYB15UFOXsvp
	 F8bG1+9TP6i2g3PwK6TNdwU8s0c0D/cEkTkTJskwEcgVTOwYG7FPLCvpDF5FKzlJb9
	 QXy9O4//LcQRg==
Date: Fri, 22 Aug 2025 20:08:26 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>,
	David Lebrun <dlebrun@google.com>, stefano.salsano@uniroma2.it
Subject: Re: [PATCH iproute2-next v2] man8: ip-sr: Document that passphrase
 must be high-entropy
Message-ID: <20250823000826.GA1336@quark>
References: <20250816031846.483658-1-ebiggers@kernel.org>
 <20250820092535.415ee6e0@hermes.local>
 <20250820184317.GA1838@quark>
 <20250820125458.0335f600@hermes.local>
 <20250821000743.0679c8cc8b41d0c9821c7727@uniroma2.it>
 <20250821032132.GA185832@quark>
 <20250823013922.Horde.J-H85jaVn6AHI0UeML3QS3m@webmail.uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823013922.Horde.J-H85jaVn6AHI0UeML3QS3m@webmail.uniroma2.it>

On Sat, Aug 23, 2025 at 01:39:22AM +0200, Paolo Lungaroni wrote:
> > 
> > Passwords and keys don't belong on the command line, since command lines
> > are often visible to all users.  Standard input is the correct way to do
> > it.  The issue you seem to referring to is that the command currently
> > works only when standard input is a tty.  It should of course be fixed
> > to work for any file, which would allow automation via something like
> > 'ip sr hmac set 17 sha256 < passphrase.txt'.  (And to be clear, that's a
> > separate issue from the lack of passphrase stretching.)
> > 
> > When giving example commands, please also use sha256 instead of sha1.
> > 
> > - Eric
> 
> Ciao Eric,
> 
> The scheme I followed to develop my patch proposal is inspired by the one
> already present in ip xfrm and ip macsec.
> These two features require the configuration of key entered inline in the
> command prompt.

Well, then those are wrong too.

> Regarding your statement: 'And to be clear, that's a separate issue from the
> lack of passphrase stretching,' yes, you're right: they are indeed separate.
> 
> According to RFC8754, 'The pre-shared key identified by HMAC Key ID' is used
> as
> is in the HMAC computation.
> 
> I'm trying to understand how 'stretching the passphrase' could work with other
> network appliances that are not Linux. Stretching the passphrase only in the
> Linux implementation seems to make it incompatible with RFC8754 and,
> consequently, with other software and hardware that implement Segment Routing
> over IPv6 HMAC.

The RFC just says there is a pre-shared HMAC key.  How it is generated
and shared is outside the scope of the RFC.

> As an example, at the computation level, I need to use the same key when
> communicating with hardware routers and when calculating an HMAC that the
> hardware device can verify. If we implement passphrase stretching in Linux,
> what would be the input string I should provide in iproute2 to ensure that the
> same key used in the hardware device (which does not perform passphrase
> stretching) is used?

The key stretching should of course be in userspace, not the kernel.

> Could you please clarify what you intend to do

Nothing.  I don't care about this feature myself.  I'm just letting the
people who do care about this feature know about this security bug that
I happened to notice.  If they don't care either, then oh well.

- Eric

