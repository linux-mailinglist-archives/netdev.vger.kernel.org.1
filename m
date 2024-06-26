Return-Path: <netdev+bounces-106944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5279183BB
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B3A28257D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FEE1684BE;
	Wed, 26 Jun 2024 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="coJ/Nk5R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F28495;
	Wed, 26 Jun 2024 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411401; cv=none; b=uh+wu/gMA6i0tgj9isvXdnQvAjNoQeta/4Vig74zr8bvU+fmG+uIOJcTEKqcm6uhiMZFfZoWJFEqj3FpfGQTXRxIdUwFWz7qIAIyApL3Ws0VEPWwJAuOH3dHvhJFULpDzuXe1xhy1ug74pk1eOEBh1VpqQOiREj6Fw+0cPo+UgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411401; c=relaxed/simple;
	bh=BRs7yKKIEJjHjfCSav5qFX0qIBT++tHJPPAaw9tc/LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErzEGAw8O6Bdo8/oX9Sdietta75/KMElt9hiHy3sJxJSU+EV4SUwKKUld7Uj3CAWb0B24cWxtB7df5g6gI1WVzEME8CY3e1fSjB4fHL+70txJlOi3sAqeLEreZs81km45sIRyYgs5GPi5Tdq8xTNxiVb2OW8E6K0XPf8k0DnTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=coJ/Nk5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34DFC116B1;
	Wed, 26 Jun 2024 14:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719411401;
	bh=BRs7yKKIEJjHjfCSav5qFX0qIBT++tHJPPAaw9tc/LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=coJ/Nk5RY2qbkjfAXZwmuX9TK89cjfAqNFDK4rpjgud7kc+brMZC8LwCyJEoBDfQU
	 idKQ6ohoAlMZAs1bLZXU9VlyZ3wk/3aIsNgI+gM+2Y+0Wbr9azLEml1W3MZL+wAjST
	 U1hHBszv9S5K8v8SQMbJAWl5devzH6+Tg8qQyT4g=
Date: Wed, 26 Jun 2024 10:16:36 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, 
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: [PATCH 2/2] Documentation: best practices for using Link trailers
Message-ID: <20240626-olivine-spaniel-of-gallantry-9c904a@meerkat>
References: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
 <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>
 <20240625172727.3dd2ad67@rorschach.local.home>
 <CAMuHMdXHa52RBjzA4eF4ERNuJjRHyq=FfyPz-yOsjOA7ZQfouQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdXHa52RBjzA4eF4ERNuJjRHyq=FfyPz-yOsjOA7ZQfouQ@mail.gmail.com>

On Wed, Jun 26, 2024 at 10:12:35AM GMT, Geert Uytterhoeven wrote:
> > > +     Link: https://patch.msgid.link/patch-source-msgid@here
> >
> > Hmm, I mentioned this in the other thread, but I also like the fact
> > that my automated script uses the list that it was Cc'd to. That is, if
> > it Cc'd linux-trace-kernel, if not, if it Cc'd linux-trace-devel, it
> > adds that, otherwise it uses lkml. Now, I could just make the lkml use
> > the patch-source-msgid instead.
> >
> > This does give me some information about what the focus of the patch
> > was. Hmm, maybe I could just make it:
> >
> >   Link: https://patch.msgid.link/patch-source-msgid@here # linux-trace-devel
> >
> > Would anyone have an issue with that?
> 
> Or, just like with lore links:
> 
>     https://patch.msgid.link/linux-trace-devel/patch-source-msgid@here

I don't recommend this because it is not always a reliable mechanism to just
take the local part of the list address and assume that it will match the list
directory on lore.kernel.org. We've had lists that moved around or got
renamed, or disambiguated for clarity.

Overall, we're generally moving away from "where was this sent?" having any
importance -- we already support lei queries and should soon have bridges
exposing patches submitted via forge interfaces. If you want to indicate the
focus of the patch, then going by the list to which it was sent is going to
increasingly lose importance.

-K

