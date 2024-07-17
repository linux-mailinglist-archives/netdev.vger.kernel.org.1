Return-Path: <netdev+bounces-111921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5AC93423F
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 20:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A1AB22831
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24871836C2;
	Wed, 17 Jul 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVl/M2+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED9718308C
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240856; cv=none; b=XakMUiOyg8JQTYEA+4KJMvcxfedEbwXgCiRARnM8n4a+U7HnTlX4zto4CYnHOnfIbraspUB21ilOhvrAKYBbbHIAMDh0ioGe/fmROWcfaoxEd0tF4lYSXyPlXaTiq0UdFgCCeEY9hDmMMALGnw0cd2KIEgRv74jMash1lO24/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240856; c=relaxed/simple;
	bh=Q0nJMMK7X0JPtgckgj4aaNBlvpWb9ozojMF+tfWk2Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKvi6OFW63DfZW9aNSnaAT3ddw4R+d0tNc0ZXKq7v42WOIkhkOWIdcEOvgCTPGw+5MTBWTsjRXY/F3zrPGA2hA0EQLgfij8AwK8/kG5IWIBg8rzaKlk2KCqtGc5CaXvOlbgA7UkHF2WSlHyk8Syobo54fv1RhX0zdIPA7LMT87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVl/M2+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E34C32782;
	Wed, 17 Jul 2024 18:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721240856;
	bh=Q0nJMMK7X0JPtgckgj4aaNBlvpWb9ozojMF+tfWk2Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pVl/M2+iugkAqjp3Lt221oVhGOR8wTX7LeFBiZQzHh/JMqcSOUcN8XjVze5b1DFo7
	 1JZJKtxb14aGTbGMzL+hv33TLeUBYtPm+tbE3KlYNRvOJXcLeF7UuDnpglnRdKcHcm
	 CPPKy3nYCFKkmBVpxg054iIfeIuM9dIcFolYFGhCkqeEebeRMwfetF7BAYPQ8y1LEV
	 cIUer2O+T/oSVCICxsPInsOvT1UbbE8IqEsF30nVkjntuPqLHHG1n6Fs0uzQdVEwOi
	 6OwnZ62agfDE10RXvFhANE1IrZOAuI2adJ2hfqjNXz7Eld0u67Roa9Ukfoab4ixZAA
	 ypIDMNl/VoTUw==
Date: Wed, 17 Jul 2024 19:27:33 +0100
From: Simon Horman <horms@kernel.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Maks Mishin <maks.mishinfz@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] f_flower: Remove always zero checks
Message-ID: <20240717182733.GQ249423@kernel.org>
References: <20240707172741.30618-1-maks.mishinFZ@gmail.com>
 <20240710161139.578d20dc@hermes.local>
 <Zpf9mlUXHZfgV+74@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zpf9mlUXHZfgV+74@debian>

On Wed, Jul 17, 2024 at 07:21:30PM +0200, Guillaume Nault wrote:
> On Wed, Jul 10, 2024 at 04:11:39PM -0700, Stephen Hemminger wrote:
> > On Sun,  7 Jul 2024 20:27:41 +0300
> > Maks Mishin <maks.mishinfz@gmail.com> wrote:
> > 
> > > Expression 'ttl & ~(255 >> 0)' is always zero, because right operand
> > > has 8 trailing zero bits, which is greater or equal than the size
> > > of the left operand == 8 bits.
> > > 
> > > Found by RASU JSC.
> > > 
> > > Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> > > ---
> > >  tc/f_flower.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tc/f_flower.c b/tc/f_flower.c
> > > index 08c1001a..244f0f7e 100644
> > > --- a/tc/f_flower.c
> > > +++ b/tc/f_flower.c
> > > @@ -1523,7 +1523,7 @@ static int flower_parse_mpls_lse(int *argc_p, char ***argv_p,
> > >  
> > >  			NEXT_ARG();
> > >  			ret = get_u8(&ttl, *argv, 10);
> > > -			if (ret < 0 || ttl & ~(MPLS_LS_TTL_MASK >> MPLS_LS_TTL_SHIFT)) {
> > > +			if (ret < 0) {
> > >  				fprintf(stderr, "Illegal \"ttl\"\n");
> > >  				return -1;
> > >  			}
> > > @@ -1936,7 +1936,7 @@ static int flower_parse_opt(const struct filter_util *qu, char *handle,
> > >  			}
> > >  			mpls_format_old = true;
> > >  			ret = get_u8(&ttl, *argv, 10);
> > > -			if (ret < 0 || ttl & ~(MPLS_LS_TTL_MASK >> MPLS_LS_TTL_SHIFT)) {
> > > +			if (ret < 0) {
> > >  				fprintf(stderr, "Illegal \"mpls_ttl\"\n");
> > >  				return -1;
> > >  			}
> > 
> > That is correct mathematically, but perhaps the original author had different idea.
> > Could we have review from someone familiar with MPLS support please.
> 
> The MPLS TTL field is an 8 bits value. Therefore any successful return
> of get_u8() should be valid and this test is indeed not needed.
> 
> I guess the original intent was to keep consistency with how the other
> MPLS parameters are validated. But TTL is indeed a special case as it's
> the only parameter with a "common" length.
> 
> Reviewed-by: Guillaume Nault <gnault@redhat.com>

Thanks Guillaume,

Yes, I agree that was very likely the intent.

Reviewed-by: Simon Horman <horms@kernel.org>


