Return-Path: <netdev+bounces-50807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FCA7F731A
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C129B21231
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17101EB42;
	Fri, 24 Nov 2023 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BASZG532"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CED200B2;
	Fri, 24 Nov 2023 11:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C931FC433C8;
	Fri, 24 Nov 2023 11:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700826792;
	bh=XHnDADyl/mLuqW5J+O0k4fs+l8mVA8e2IA7fajuKfCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BASZG532fKp8ghNds6SwiWPo5+a/jkHQztlzmcv3KliPxgpkCqRuEfl4srcNFljWI
	 vG+1SQ2OAGuCsqYv9uPMZXO1D6BS6McEj07Wo1K2ucEpaaUt71U2TeUCohTM26KymB
	 +vEFoCHpTqOoXOsEM2CgY3I+0UeYxdyKGsqjxZtlwhb8kNXZqJA/OyU8krwTWBjrzq
	 kMURkEKD7hRaHpaQekfJ1s5/k0roH170FgcrBryhEVGnxTH9O9mCpy6yW36mdPFZZ7
	 cg9oPw7Wj8aeCwqRtrjxXONsQU6mvg8+2fBLJgwUD2qdc+otmoo5p7KuGPg8sztyKO
	 KDzCLtojYQ81g==
Date: Fri, 24 Nov 2023 11:53:07 +0000
From: Simon Horman <horms@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>, dmitry.bezrukov@aquantia.com,
	marcinguy@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCHv2] USB: gl620a: check for rx buffer overflow
Message-ID: <20231124115307.GP50352@kernel.org>
References: <20231122095306.15175-1-oneukum@suse.com>
 <2c1a8d3e-fac1-d728-1c8d-509cd21f7b4d@omp.ru>
 <367cedf8-881b-4b88-8da0-a46a556effda@suse.com>
 <5a04ff8e-7044-2d46-ab12-f18f7833b7f5@gmail.com>
 <2338f70a-1823-47ad-8302-7fb62481f736@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2338f70a-1823-47ad-8302-7fb62481f736@suse.com>

On Wed, Nov 22, 2023 at 11:20:47AM +0100, Oliver Neukum wrote:
> 
> 
> On 22.11.23 11:07, Sergei Shtylyov wrote:
> > On 11/22/23 1:04 PM, Oliver Neukum wrote:
> > 
> > [...]
> > > > > The driver checks for a single package overflowing
> > > > 
> > > >      Maybe packet?
> > > 
> > > No, that would be read as network packet, which
> > > is precisely what this not not and should not
> > > be mistaken for.
> > 
> >     But "package" hardly fits either. Is it a USB packet or something else?
> 
> Technically the content of the buffer associated
> with a single URB. Which on USB physically can be multiple
> packets. The network packets arrive together in a package.
> That is how this and related drivers operate.

I think it would be useful to include information along the lines
of the above in the patch description.

