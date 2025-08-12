Return-Path: <netdev+bounces-212829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDF4B2233E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B852188CC13
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE9D2E8E17;
	Tue, 12 Aug 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvfpCxXs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21C2E8DEF;
	Tue, 12 Aug 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990999; cv=none; b=JvDCsns3Rb+ZeU5UUeJoq4ZufduC/nA4YR1Zo9p7zBCciqViFjlU54QI2KKTuO36e/Z66jSFMWbF0P7+ANDQW8sH2PPBA52SS6dSVvO0Ph//X5SLwUfxMmmHpIZM+fp1W+81ROC2fHiC4Jt/fvBPJeKrlwqx4aKktjaxJKIVrNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990999; c=relaxed/simple;
	bh=cl13ks3RMDMRkenBirnwLiT2Adt0+X+IQNuEJFe/zlk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMn2IsxzLTKlISGFsPvKgWad7NXOO4iR6j3rZqVHdLoKV8HCYl0KNfxTIJOlu5R/okGvBSfrAddro3XCJvgym89Uxjy3+v1BsrPxgayANIzMmxVLw1iuMSb+gnDSae7aKYKyMqjMGndHLMjWII6Spsut5wbJC+mwaQ3nVhKZJRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvfpCxXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DBAC4CEF0;
	Tue, 12 Aug 2025 09:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754990998;
	bh=cl13ks3RMDMRkenBirnwLiT2Adt0+X+IQNuEJFe/zlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MvfpCxXspMYE27SmyghqGuBXQlOP4OBMm4AUikjzBeTJqd8Rzo79mARKyhtBiWej/
	 Lc+6ZwZkG4JSSIEXGWW1dQ92lVtiLc7hM/I7Yqb16MnEgOwOi8oSqZEGcmkCYCewhL
	 2qrcznGaUHYmY0qpS8xfTRWx1yt/n0oiKsX/byfrxkgzGM4j6UNCCe60QpCQkZOigQ
	 3qIFKlMYjOqWsPFGFxU6uw5RFUwXlDmXeJzLTbhXJYedsvF96cH4QiHbV1/Z1l/tJb
	 IlkV2E5Mcn5djqW/CzLHlxqBIYvC7GOXNVQkIWBfRSEDzhhnjE3fGUySydT81mH7Yq
	 LWqYpnVzcgHSQ==
Date: Tue, 12 Aug 2025 11:29:50 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, "David S. Miller" <davem@davemloft.net>, Ignacio
 Encinas Rubio <ignacio@iencinas.com>, Marco Elver <elver@google.com>, Shuah
 Khan <skhan@linuxfoundation.org>, Donald Hunter <donald.hunter@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jan Stancek <jstancek@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu, Breno Leitao <leitao@debian.org>, Randy Dunlap
 <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v10 00/14] Don't generate netlink .rst files inside
 $(srctree)
Message-ID: <20250812112950.0de576fc@foz.lan>
In-Reply-To: <20250811175648.04ccd9de@kernel.org>
References: <cover.1753718185.git.mchehab+huawei@kernel.org>
	<87ms85daya.fsf@trenco.lwn.net>
	<20250811175648.04ccd9de@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 17:56:55 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 11 Aug 2025 11:28:45 -0600 Jonathan Corbet wrote:
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:  
> > > That's the v10 version of the parser-yaml series, addressing a couple of
> > > issues raised by Donald.
> > >
> > > It should apply cleanly on the top of docs-next, as I just rebased on
> > > the top of docs/docs-next.
> > >
> > > Please merge it via your tree, as I have another patch series that will
> > > depend on this one.    
> > 
> > I intend to do that shortly unless I hear objections; are the netdev
> > folks OK with this work going through docs-next?  
> 
> No objections.
> 
> Would you be willing to apply these on top of -rc1, and create a merge
> commit? YNL is fairly active, if there's a conflict we may be testing
> our luck if Linus has to resolve Python conflicts.
> 
> Happy to do that on our end (we have a script:)), or perhaps Mauro could
> apply and send us both a PR?

Whatever works best for you. In case you decide for the PR, I'm sending 
one right now for you both. It is on a stable signed tag:

	https://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs.git/tag/?h=docs/v6.17-1

So, if both of you pick from it, we should be able to avoid conflicts on
the next merge window, as I don't have any patches changing the Sphinx
yaml parser plugin nor netlink tools.

It should be noticed that I have a patch series that does a major 
cleanup at Documentation/Makefile. It is based after this series.

So, better to have the series merged at linux-docs to avoid merge
conflicts at linux-next and during the next merge window.

Thanks,
Mauro

