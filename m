Return-Path: <netdev+bounces-215384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD783B2E528
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 20:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7757A4272
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 18:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BEC27AC43;
	Wed, 20 Aug 2025 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvGvHeX2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE892566E2
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755715399; cv=none; b=Boot9upNwvRlVOXX5Wx5A4mAHZOEfucOcrURW6O1aZM0jOziBtBvW29yqbrIRdowQ2Ya8f33/YcTnGXsvx6lo4yjI6vluieHtZuH0embu+Oc5yurTcz215/xHKCwAZeb070o5RcrONmcdI+KSc+jxebblfbY/9/AK0k99TKXgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755715399; c=relaxed/simple;
	bh=cOpbY3wt9qAPgLlHoEgGI3YhBqCs2c6VUZ0/FKbKeZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDHsXm2H9doFKBaQXA6v8+nrhBOGyzOWYHQKKyD4SuRBYnoOqQSLTHdYV8SIZjLytjq8zg8hIYKGUrVOO8KmRokh6qmO+IXcqWc4q3se+41kwYijUhq7+d2QNuttch2yBGiP3Ftz5Xc1upmxyRi1KG+Ms5XnH/CpbPE0pUhssA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvGvHeX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCA9C4CEE7;
	Wed, 20 Aug 2025 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755715399;
	bh=cOpbY3wt9qAPgLlHoEgGI3YhBqCs2c6VUZ0/FKbKeZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvGvHeX2zdRnxreRZs2FqPt6tHHEGHgxyMNb5Uy3As/T7KCHg87V8d0h941YT2ep9
	 /fc5ZCGDscOz6giV/8BQXJPFzuHMqJUqM4XKj9aNBp5dQzhrZ9rJ1Nl1IXs8R1qES9
	 7ex+uH/Yq5NZvLpQSzuO9MAZ/bcerCGTvptUuoWkYUO7omYLyRqhkRjnOR9fTmd5cM
	 pShKSFL3Vd/DeqXqVjZf2t/H8aOYfyL6FTDncz/cSse5VgZXMnlUweO7m8eYNs1Bw5
	 RTPMdKVKINuaALdQ50qc2uG5sIcGkZ5W8Q0n/luKvPlqOc6cPpoGgAXQx5I7OBuHMt
	 42OjaVhkTjnpQ==
Date: Wed, 20 Aug 2025 11:43:17 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	David Lebrun <dlebrun@google.com>
Subject: Re: [PATCH iproute2-next v2] man8: ip-sr: Document that passphrase
 must be high-entropy
Message-ID: <20250820184317.GA1838@quark>
References: <20250816031846.483658-1-ebiggers@kernel.org>
 <20250820092535.415ee6e0@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820092535.415ee6e0@hermes.local>

On Wed, Aug 20, 2025 at 09:25:35AM -0700, Stephen Hemminger wrote:
> On Fri, 15 Aug 2025 20:18:46 -0700
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > diff --git a/man/man8/ip-sr.8 b/man/man8/ip-sr.8
> > index 6be1cc54..cd8c5d18 100644
> > --- a/man/man8/ip-sr.8
> > +++ b/man/man8/ip-sr.8
> > @@ -1,6 +1,6 @@
> > -.TH IP\-SR 8 "14 Apr 2017" "iproute2" "Linux"
> > +.TH IP\-SR 8 "15 Aug 2025" "iproute2" "Linux"
> 
> NAK - do not change man page date for each change.

Sure, if that's the convention for this project.  Note that this differs
from the convention used by most projects with dated man pages.  The
purpose of the date is normally to indicate how fresh the man page is.

> >  .SH "NAME"
> >  ip-sr \- IPv6 Segment Routing management
> >  .SH SYNOPSIS
> >  .sp
> >  .ad l
> > @@ -32,13 +32,21 @@ internal parameters.
> >  .PP
> >  Those parameters include the mapping between an HMAC key ID and its associated
> >  hashing algorithm and secret, and the IPv6 address to use as source for encapsulated
> >  packets.
> >  .PP
> > -The \fBip sr hmac set\fR command prompts for a passphrase that will be used as the
> > -HMAC secret for the corresponding key ID. A blank passphrase removes the mapping.
> > -The currently supported algorithms for \fIALGO\fR are \fBsha1\fR and \fBsha256\fR.
> > +The \fBip sr hmac set\fR command prompts for a newline-terminated "passphrase"
> 
> That implies that newline is part of the pass phrase.

Not really.  "NUL-terminated" strings don't include the NUL in the
string content.  If you prefer, it could be made explicit as follows:

    The \fBip sr hmac set\fR command prompts for a "passphrase" that
    will be used as the HMAC secret for the corresponding key ID. The
    passphrase is terminated by a newline, but the terminating newline
    is not included in the resulting passphrase.

But I don't think it's very useful, as it's not needed to know how to
use the command correctly.

> The code to read password is using getpass() which is marked as obsolete
> in glibc. readpassphrase is preferred.

Is that relevant to this documentation patch?

> > +that will be used as the HMAC secret for the corresponding key ID. This
> > +"passphrase" is \fInot\fR stretched, and it is used directly as the HMAC key.
> > +Therefore it \fImust\fR have enough entropy to be used as a key. For example, a
> > +correct use would be to use a passphrase that was generated using
> > +\fBhead\~-c\~32\~/dev/urandom\~|\~base64\~-w\~0\fR.
> 
> Shouldn't /dev/random be used instead of /dev/urandom for keys.

If you prefer that as the maintainer of this code, sure.  There are
reasons to use either one, and it's been an endless debate for years.

- Eric

