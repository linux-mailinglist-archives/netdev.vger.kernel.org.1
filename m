Return-Path: <netdev+bounces-105813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903F0912FA5
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 23:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB266B21828
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 21:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EE017C226;
	Fri, 21 Jun 2024 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="znN+MfEU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D9208C4;
	Fri, 21 Jun 2024 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005832; cv=none; b=TuWpleDry3w1zsF+45J1PRJh2vODZ0jwus4GPfIv26zrdcMO+WFe92TvlpD1NgFEq59z9x+uzwVN7qDWLecfsQ4RHN/GK3We5S3iZYhHsXVKpjm4tn2LCMU1iW4eGHmvgCq3sBjowfBnSS9Nh3IfiC0APuu8YogpVSVzFdBJ6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005832; c=relaxed/simple;
	bh=HqB7/AiiMRvyE1Jtm5iJcbfxhyhyihsPuCco+kkArsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkBhvflch6ocxljAR/zKSFeNBGD4kGo1zBQtn2sU9uSxLIsbDzfCHW7SYKN72Xyklji7HQOrqUQBKsAVLBoDxs3K0dRp88CJBS/cJ0eEyaUYMymFGs6bON5RWWejUlFcvKn0WiCJPuPOM5lmehq5L9aglhUk9bTto/B9Hsn/1S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=znN+MfEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBB3C2BBFC;
	Fri, 21 Jun 2024 21:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719005831;
	bh=HqB7/AiiMRvyE1Jtm5iJcbfxhyhyihsPuCco+kkArsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=znN+MfEU4yTVh3qkQUN8MlWRuNI/dIs1ZQ/kTFRfl0JsI1fsVJ/j//iDo29ZvPb5+
	 J1J3fAxZurEhKzfuN2gssGCiefy5/5dFZrm8Va7B8A5ESC/I5pfLCg9sVgWPa2LXyF
	 cNd0SArSL9CmDCfo9pO6lacTxqQEjHH6dn4iWTrk=
Date: Fri, 21 Jun 2024 17:37:10 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: [PATCH v2 2/2] Documentation: best practices for using Link
 trailers
Message-ID: <20240621-amorphous-topaz-cormorant-cc2ddb@lemur>
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
 <20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org>
 <202406211355.4AF91C2@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202406211355.4AF91C2@keescook>

On Fri, Jun 21, 2024 at 02:07:44PM GMT, Kees Cook wrote:
> On Wed, Jun 19, 2024 at 02:24:07PM -0400, Konstantin Ryabitsev wrote:
> > +   This URL should be used when referring to relevant mailing list
> > +   topics, related patch sets, or other notable discussion threads.
> > +   A convenient way to associate ``Link:`` trailers with the commit
> > +   message is to use markdown-like bracketed notation, for example::
> > ...
> > +     Link: https://lore.kernel.org/some-msgid@here # [1]
> > +     Link: https://bugzilla.example.org/bug/12345  # [2]
> 
> Why are we adding the extra "# " characters? The vast majority of
> existing Link tags don't do this:

That's just convention. In general, the hash separates the trailer from the
comment:

    Trailer-name: actual-trailer-body # comment

-K

