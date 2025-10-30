Return-Path: <netdev+bounces-234470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26353C21003
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 16:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219F23AD5F8
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060723644BD;
	Thu, 30 Oct 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUUKyOn2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FE363B9B;
	Thu, 30 Oct 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839054; cv=none; b=rYXvxItT28WMln44v3uaAmxEa8hQPsZLk8I5qdNhhftjLnHcPABf0hzpP3BHiFdQQOF/KcbFztdLD7sTmGvs8QQw1RiVsAFFUNywqrbgu2o1edGWZFFIL8yOJU5eJsNRghHxTwXQQMircFWgFMWJD7+ci9eeY8Y0ceEKjAJPAug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839054; c=relaxed/simple;
	bh=JoN9bOfYN5t27jBlcfRUcHukPv9SyF0gBai28vsjgRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DprTzk2SW2xTHM/Llv7A+ifx3IXI0p4G0xc0YlE26tCbDob25lBlIpRx5IUYzdFLVuOolVI17FxsQaUALY6XzbGKSEcVgM65ZInWfAxNS9EqloDq+d+Z71ESMFMt/vS8ndoCHvUpx1yI+Lss8hLTUOW5VOxGG2qNx2Poviotkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUUKyOn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AEFC4CEF1;
	Thu, 30 Oct 2025 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761839054;
	bh=JoN9bOfYN5t27jBlcfRUcHukPv9SyF0gBai28vsjgRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jUUKyOn2f1XkKxm0E2S0BADUlPoR6bldkrD+KbzpL+TAJ7u2FaTc5LMrPt1/n8ldQ
	 Qit35+NkAeUeF3txP2Y2qS59qYmXPkUzcc71iNC9fot45gllq7mu9WtXA7b0GcFcsD
	 VRVKXq7qdnJT1ctgyvw2Fagiq1ih2Xc49j2jvZz8NAEqE4Livc1fZDqQWL+Hhm8DIZ
	 hHzJ1HoGz7WhszoTKRxdQoEMCbrm7Pdk2A2LImlElgJd19nN3m08xiinu52NcwnJPB
	 XzhAYt/6ijgba1ngAwpNPMTThAnaigXi/h0sSek1yCtwnNXz1czNPJNH9NHvh1FMWX
	 VEzLPRn9YXW/A==
Date: Thu, 30 Oct 2025 08:44:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Herbert Xu
 <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net-next 6/6] MAINTAINERS: Add entry for XFRM
 documentation
Message-ID: <20251030084412.5f4dc096@kernel.org>
In-Reply-To: <20251030084158.61455ddc@kernel.org>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
	<20251029082615.39518-7-bagasdotme@gmail.com>
	<aQMd886miv39BEPC@secunet.com>
	<20251030084158.61455ddc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 08:41:58 -0700 Jakub Kicinski wrote:
> On Thu, 30 Oct 2025 09:12:35 +0100 Steffen Klassert wrote:
> > On Wed, Oct 29, 2025 at 03:26:14PM +0700, Bagas Sanjaya wrote:  
> > > XFRM patches are supposed to be sent to maintainers under "NETWORKING
> > > [IPSEC]" heading, but it doesn't cover XFRM docs yet. Add the entry.
> > > 
> > > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index d652f4f27756ef..4f33daad40bed6 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -18041,6 +18041,7 @@ L:	netdev@vger.kernel.org
> > >  S:	Maintained
> > >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
> > >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
> > > +F:	Documentation/networking/xfrm/    
> > 
> > That means that I'm now responsible for this.
> > But I'm OK with it if nobody has objections on it.  
> 
> Definitely no objections :) 
> Let me mark this series as "Awaiting Upstream".

I take back the "Awaiting Upstream" part. This set conflicts with 
the big ToC tree reorg patch. Let's either merge this into net-next 
or wait for trees to re-sync?

Not a big deal but the conflict is easily avoidable ...

