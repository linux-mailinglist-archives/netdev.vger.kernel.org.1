Return-Path: <netdev+bounces-132786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EAD9932E6
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23CE282291
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1241DB554;
	Mon,  7 Oct 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HygSmkIZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E71DA612;
	Mon,  7 Oct 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317705; cv=none; b=RjCkJR/GCHsf1B9u7djWVZplQ78WnugKd4ttCddsI726Sh/jSQULfLIcFnWGFo0cw5/IUqMDc8aB+yiYkOtZI0zkRgSM/M6F6fyRz17BA3wyTmS+aJqttCHH5/LxNN0X5sMHbIEKVzivyYEjPWVSmDqUdUuzhi01f4YwR7dQ0RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317705; c=relaxed/simple;
	bh=Knc/n06lUCBzEg/MaJUZ9xZ2CL63eO+/E7Q+GKdNcAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/wqfp3V3F+AoKDzv2kpFhFRTmIUZruPpFnXldm7TmkF9Tw7gxM4tGB1C9UZoYE91Wkn5Orj6sSQ7r4Z7RQe1ll143ufuSh9eDpsK6dfootezlcltKnbImJIXvVitUsQzb0E3UAFeChXE8R5NWBrHh8k9yGJygp5t96aaWAK3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HygSmkIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585A9C4CEC6;
	Mon,  7 Oct 2024 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728317705;
	bh=Knc/n06lUCBzEg/MaJUZ9xZ2CL63eO+/E7Q+GKdNcAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HygSmkIZuibgM7c/Qm0ebdk/E6+pz/kp9ee5dsZJNQENP/+4BSVlMgbQGdKL2P5wk
	 C7+f0jPId41Nph7hx3V9f5DDIAmQwa4c7ugzsuPsBrGU2LvyHcqaRb2QH4Cz7kOygn
	 g+j5+QN2fu67yZClL4vNYPnzUkef3yHF+clhCaA2DyQow/nsJgjGGqwFHUdBYwLNLh
	 WQYoOrK4PLvChyiWF/RQGdvCVES22N0STBiCKJ5bjMhhRgGPaZA5jxGJDPlMwY/wWd
	 7IS7U1KFLduFJUo9V9GY0400vdh4LAZCFhvGjwZPzpeUSbopocHv/0/EG6LVgzkPMz
	 8g9721PohQk0g==
Date: Mon, 7 Oct 2024 17:15:01 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net] docs: netdev: document guidance on cleanup
 patches
Message-ID: <20241007161501.GJ32733@kernel.org>
References: <20241004-doc-mc-clean-v1-1-20c28dcb0d52@kernel.org>
 <20241007082430.21de3848@kernel.org>
 <20241007155521.GI32733@kernel.org>
 <20241007090828.05c3f0da@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007090828.05c3f0da@kernel.org>

On Mon, Oct 07, 2024 at 09:08:28AM -0700, Jakub Kicinski wrote:
> On Mon, 7 Oct 2024 16:55:21 +0100 Simon Horman wrote:
> > > > +Netdev discourages patches which perform simple clean-ups, which are not in
> > > > +the context of other work. For example addressing ``checkpatch.pl``
> > > > +warnings, or :ref:`local variable ordering<rcs>` issues. This is because it
> > > > +is felt that the churn that such changes produce comes at a greater cost
> > > > +than the value of such clean-ups.  
> > > 
> > > Should we add "conversions to managed APIs"? It's not a recent thing,
> > > people do like to post patches doing bulk conversions which bring very
> > > little benefit.  
> > 
> > Well yes, I agree that is well established, and a common target of patches.
> > But isn't that covered by the previous section?
> > 
> >    "Using device-managed and cleanup.h constructs
> >     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> >    "Netdev remains skeptical about promises of all “auto-cleanup” APIs,
> >     including even devm_ helpers, historically. They are not the preferred
> >     style of implementation, merely an acceptable one.
> > 
> >     ...
> > 
> >    https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
> > 
> > We could merge or otherwise rearrange that section with the one proposed by
> > this patch. But I didn't feel it was necessary last week.
> 
> Somewhat, we don't push back on correct use of device-managed APIs.
> But converting ancient drivers to be device-managed just to save 
> 2 or 3 LoC is pointless churn. Which in my mind falls squarely
> under the new section, the new section is intended for people sending
> trivial patches.

Thanks, I can try and work with that. Do you want to call out older drivers
too? I was intentionally skipping that for now. But I do agree it should
be mentioned at some point.

> > > On the opposite side we could mention that spelling fixes are okay.
> > > Not sure if that would muddy the waters too much..  
> > 
> > I think we can and should. Perhaps another section simply stating
> > that spelling (and grammar?) fixes are welcome.
> 
> Hm, dunno, for quotability I'd have a weak preference for a single
> section describing what is and isn't acceptable as a standalone cleanup.

Sure.

