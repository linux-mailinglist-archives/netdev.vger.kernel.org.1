Return-Path: <netdev+bounces-215478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E26F7B2EBDC
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 05:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527A11CC1690
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EF92D3233;
	Thu, 21 Aug 2025 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnWO77UP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D18277020
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 03:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755746496; cv=none; b=DU5B8x1yBZNtcpe2i45RHGqj0J0UQILht8vo74NbVkGAx+jo5jb9cCGiDJXN0laN79JsN9ybu4uPPif1qqKIhmV8J/JHO8vVVMjAZNlKjcMQGT5q3QLXxvoM+5oD6uMHjAtLrgxlZceKHHo3que3x3DEvzTuM4w04RK8poMyJMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755746496; c=relaxed/simple;
	bh=rCw9dOTDpSMyGZO9B6gfEfJiL9XKNu6ovIIUjIlVaMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBcb9691Om1ggfjZ0NU4fyV+zojNyQZ9LdXwZCo6cVInY2v35jnBSa/5DkoLK6PCMFvy/V0PLgNkIP0yp5/uL0ppFQOVpgjgqc+EaMATPpnAKLUVzBQPKP9BN7DlUbzxLBOVos0DMF+JmqeoANI1PV5RhZ8rLUZE/C8QtGpcNuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnWO77UP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D434EC4CEF4;
	Thu, 21 Aug 2025 03:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755746495;
	bh=rCw9dOTDpSMyGZO9B6gfEfJiL9XKNu6ovIIUjIlVaMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MnWO77UPJRyq8b4Dl09cu/ciE98zaJtyUvWOLrNWu0HYM2ln5xNzpFI6yjjl7huTh
	 FRwySeSYSXfQ6tREk2EA8y//aoiYWMqYnwKnruI858R+bOKv0b1o6/1JSI99pr6ANR
	 YLOOnGvAetxQyEISu6zVcEUxamUAvw/MjIh7iG/ROFCCIkG+rOqBEz3UhocHg7VPNb
	 wm6NClZkXmvV5id1i504O0GHv1B3JfwJgKeiMZ4g81D+h1iKuQYohgG26tHPHoDffX
	 WbrP1Am/RgpWGN+B3Q3wLebqPN/ij3wOCHYpbkni+LtsGuhf5emhukgskYSUnhzzsh
	 oBO52I4C9m9AA==
Date: Wed, 20 Aug 2025 23:21:32 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	David Ahern <dsahern@gmail.com>, David Lebrun <dlebrun@google.com>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	stefano.salsano@uniroma2.it
Subject: Re: [PATCH iproute2-next v2] man8: ip-sr: Document that passphrase
 must be high-entropy
Message-ID: <20250821032132.GA185832@quark>
References: <20250816031846.483658-1-ebiggers@kernel.org>
 <20250820092535.415ee6e0@hermes.local>
 <20250820184317.GA1838@quark>
 <20250820125458.0335f600@hermes.local>
 <20250821000743.0679c8cc8b41d0c9821c7727@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821000743.0679c8cc8b41d0c9821c7727@uniroma2.it>

On Thu, Aug 21, 2025 at 12:07:43AM +0200, Andrea Mayer wrote:
> On Wed, 20 Aug 2025 12:54:58 -0700
> Stephen Hemminger <stephen@networkplumber.org> wrote:
> 
> > On Wed, 20 Aug 2025 11:43:17 -0700
> > Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> > > On Wed, Aug 20, 2025 at 09:25:35AM -0700, Stephen Hemminger wrote:
> > > > On Fri, 15 Aug 2025 20:18:46 -0700
> > > > Eric Biggers <ebiggers@kernel.org> wrote:
> > > >   
> > > > > diff --git a/man/man8/ip-sr.8 b/man/man8/ip-sr.8
> > > > > index 6be1cc54..cd8c5d18 100644
> > > > > --- a/man/man8/ip-sr.8
> > > > > +++ b/man/man8/ip-sr.8
> > > > > @@ -1,6 +1,6 @@
> > > > > -.TH IP\-SR 8 "14 Apr 2017" "iproute2" "Linux"
> > > > > +.TH IP\-SR 8 "15 Aug 2025" "iproute2" "Linux"  
> > > > 
> > > > NAK - do not change man page date for each change.  
> > > 
> > > Sure, if that's the convention for this project.  Note that this differs
> > > from the convention used by most projects with dated man pages.  The
> > > purpose of the date is normally to indicate how fresh the man page is.
> > > 
> > > > >  .SH "NAME"
> > > > >  ip-sr \- IPv6 Segment Routing management
> > > > >  .SH SYNOPSIS
> > > > >  .sp
> > > > >  .ad l
> > > > > @@ -32,13 +32,21 @@ internal parameters.
> > > > >  .PP
> > > > >  Those parameters include the mapping between an HMAC key ID and its associated
> > > > >  hashing algorithm and secret, and the IPv6 address to use as source for encapsulated
> > > > >  packets.
> > > > >  .PP
> > > > > -The \fBip sr hmac set\fR command prompts for a passphrase that will be used as the
> > > > > -HMAC secret for the corresponding key ID. A blank passphrase removes the mapping.
> > > > > -The currently supported algorithms for \fIALGO\fR are \fBsha1\fR and \fBsha256\fR.
> > > > > +The \fBip sr hmac set\fR command prompts for a newline-terminated "passphrase"  
> > > > 
> > > > That implies that newline is part of the pass phrase.  
> > > 
> > > Not really.  "NUL-terminated" strings don't include the NUL in the
> > > string content.  If you prefer, it could be made explicit as follows:
> > > 
> > >     The \fBip sr hmac set\fR command prompts for a "passphrase" that
> > >     will be used as the HMAC secret for the corresponding key ID. The
> > >     passphrase is terminated by a newline, but the terminating newline
> > >     is not included in the resulting passphrase.
> > > 
> > > But I don't think it's very useful, as it's not needed to know how to
> > > use the command correctly.
> > > 
> > > > The code to read password is using getpass() which is marked as obsolete
> > > > in glibc. readpassphrase is preferred.  
> > > 
> > > Is that relevant to this documentation patch?
> > > 
> > > > > +that will be used as the HMAC secret for th
> > 
> > Since this is only part of iproute2 that uses getpass() probably should
> > be rethought. Having key come from terminal seems hard to script
> > and awkward.
> 
> Hi Stephen,
> 
> Recently, I started working on implementing some self-tests for SRv6 on HMAC.
> The command:
> 
>   ip sr hmac set <keyid> <algo>
> 
> uses getpass() internally, as you mentioned earlier, which can be inconvenient
> for automation.
> 
> To address this, Paolo Lungaroni has extended the command to support an
> additional parameter called "secret" (this is within our internal fork of
> iproute2):
> 
>   ip sr hmac set 17 sha1 secret <your-secret>
> 
> This enhancement allows the secret to be specified directly on the command
> line, making it much more convenient for scripting and automated testing
> environments.
> If the "secret" parameter is not provided, the command will continue to behave
> as before, prompting for the passphrase interactively (i.e., the legacy
> behavior; we haven't modified the getpass() function, but we can consider to
> update it).
> 
> If you're interested, I can reach out to Paolo Lungaroni, the author of this
> patchset, tomorrow morning (CEST) and ask him to prepare everything for
> submission, including updates to the man page.

Passwords and keys don't belong on the command line, since command lines
are often visible to all users.  Standard input is the correct way to do
it.  The issue you seem to referring to is that the command currently
works only when standard input is a tty.  It should of course be fixed
to work for any file, which would allow automation via something like
'ip sr hmac set 17 sha256 < passphrase.txt'.  (And to be clear, that's a
separate issue from the lack of passphrase stretching.)

When giving example commands, please also use sha256 instead of sha1.

- Eric

