Return-Path: <netdev+bounces-162493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A737A270B8
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA1F3A43D6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4005A20CCC3;
	Tue,  4 Feb 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5w3gSFe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1244320B1EC;
	Tue,  4 Feb 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670182; cv=none; b=mGbbhBH4NKw6LVAz0XTkmUSS9SErpvObJllsaBMsfwvkCjM1OKOv+yx8Ejb1RtaDhh3uE8jUEWl/F+7oPqoQC9/XQ/j7MNIBLYGMzpTx2Oz0fEVLm7lJi7knixtV7wO9CcnGWx/N6FfMV8ZJDV26ujabuZP7Cld5JusWQpZYGtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670182; c=relaxed/simple;
	bh=haZK6H+/dG9I14HxC9VE1cwMwU7y0JmhywvJnm6WlvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1cehw+py1HpwDUrMnFkV4VJUVGKP6/Vp72gVtOGbIr1KYzjxGL4PMekZVD97l9U9ayXJJ30wZpNJKk8E2AgotHV7J43NHGOFGbucOeOy90nio645FXlEAF3r7cWW7FrPUWBZRVlp2RClYEWEFQJxbTSUNiJv6a4jBtBaIusEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5w3gSFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC3EC4CEDF;
	Tue,  4 Feb 2025 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738670181;
	bh=haZK6H+/dG9I14HxC9VE1cwMwU7y0JmhywvJnm6WlvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5w3gSFevk6xDr2Kp5OhmqVxycilJtwHRn53L6q+MDzLmSuuBkhlmsMtnoR21uV1t
	 sdeZgLISx+1YsFkl7EcgtwE5sXOyUx7FYGcK5u62OxFW5MseCJpwJVASmw/03E4qZu
	 AcFisgp/EsV0iC+ANzCTFuQ98yCKhwJhgS7zoYzTAMHqUfQqFrbqS8q3cjobXeS3IV
	 Y0xrLpNJxV1v84XtT+t4e3obViABfsUv3FsObny87Reo+jwn/GtaMGKL/e4Wgb22i7
	 aMVH6Aug3eDm37jbcJR3wAogFxt7Wy9N1vG39swe+nhsZFg3mTrzhmMCZJWV8rLFbg
	 U7TrL6gPonmFg==
Date: Tue, 4 Feb 2025 11:56:17 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
	netdev@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: Document guidance on inline functions
Message-ID: <20250204115617.GY234677@kernel.org>
References: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
 <f3600acf-63d9-4504-8b11-7b0c8ca4c3f3@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3600acf-63d9-4504-8b11-7b0c8ca4c3f3@infradead.org>

On Mon, Feb 03, 2025 at 10:51:49AM -0800, Randy Dunlap wrote:
> Hi Simon,
> 
> Another nit:
> 
> On 2/3/25 5:59 AM, Simon Horman wrote:
> > Document preference for non inline functions in .c files.
> > This has been the preference for as long as I can recall
> > and I was recently surprised to discover that it is undocumented.
> > 
> > Reported-by: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
> > Closes: https://lore.kernel.org/all/9662e6fe-cc91-4258-aba1-ab5b016a041a@orange.com/
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> >  Documentation/process/maintainer-netdev.rst | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> > index e497729525d5..1fbb8178b8cd 100644
> > --- a/Documentation/process/maintainer-netdev.rst
> > +++ b/Documentation/process/maintainer-netdev.rst
> > @@ -408,6 +408,17 @@ at a greater cost than the value of such clean-ups.
> >  
> >  Conversely, spelling and grammar fixes are not discouraged.
> >  
> > +Inline functions
> > +----------------
> > +
> > +The use of static inline functions in .c file is strongly discouraged
> > +unless there is a demonstrable reason for them, usually performance
> > +related. Rather, it is preferred to omit the inline keyword and allow the
> > +compiler to inline them as it sees fit.
> > +
> > +This is a stricter requirement than that of the general Linux Kernel
> > +:ref:`Coding Style<codingstyle>`
> 
> Is there an ending period (full stop) after that sentence?
> Could/should there be?

Thanks,

I think so. I will add one.

