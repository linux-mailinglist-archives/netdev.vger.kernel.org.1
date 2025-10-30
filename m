Return-Path: <netdev+bounces-234469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35427C20FCA
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 16:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6FEB34F289
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1593644BE;
	Thu, 30 Oct 2025 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmGSbGrb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBFE3644BA;
	Thu, 30 Oct 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838920; cv=none; b=MjwY/tvsk11oRXv8WsrrwB+mL0SozFHLKyvYEArtOlbcHfw1Vwil97UH97S0uI09RrdqFwDmw9OFwmjfEloftO/ldMZMGd1P9znzXjr1xPbZqgfZlLvJ/L94xe2PgLn3eJiKjb1v/CoLUE/vgoNVnX0BaY5aCDkbiOnpI3WAqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838920; c=relaxed/simple;
	bh=8Jq8ov3JKHNk+eVSjjv5F9o8vwOEzm1GthmDKzsDmRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhmdWzMCrMRfhi2K2yQYpvTv1BAk4UFl479Z1PpHJBWXmKzpPJcVntEU7nwRVpKihYqyiDQjNRfNCGJOiuYumdIodr7roHDu5U4iNxY8/LCd+vG3Sh++GKsolEbcfz/n5O5uoHcYadQcmiNE/k0LAJmStrTH9paP6R/dTh1mKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmGSbGrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A33DC4CEF1;
	Thu, 30 Oct 2025 15:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761838919;
	bh=8Jq8ov3JKHNk+eVSjjv5F9o8vwOEzm1GthmDKzsDmRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GmGSbGrbowTZAcFCMEHFnLyqaXEtYyQk1uiyYRoIZWwFlHEd4xLD1q1NL3Y7YN2x8
	 8TTrp96KuJFe17wzZab6A/SDvTQpZZ3J4aQ9BtaG0+HRA4UceUXFcWolIEKxJntGKE
	 ayeU7h9kpFVpU7gHMv9oQ1zBcP5+/+lwsGyDDyoyI0AMGgEayd+MGLVmrHx7wpYdf2
	 xL1LdujLrbwRSSCZV0aIP9/CuWsxmMgn5w4RhVdHrz9mR9ZW4HWfJGU2PCYEYEMLR4
	 jC0SrF8vs6P6n3RdVQJGh3bOd0NpmYYoX4eIprwWLcUwGMMxITlOqHjnz53N1Pnxwa
	 c/ViuHLCovsLw==
Date: Thu, 30 Oct 2025 08:41:58 -0700
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
Message-ID: <20251030084158.61455ddc@kernel.org>
In-Reply-To: <aQMd886miv39BEPC@secunet.com>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
	<20251029082615.39518-7-bagasdotme@gmail.com>
	<aQMd886miv39BEPC@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 09:12:35 +0100 Steffen Klassert wrote:
> On Wed, Oct 29, 2025 at 03:26:14PM +0700, Bagas Sanjaya wrote:
> > XFRM patches are supposed to be sent to maintainers under "NETWORKING
> > [IPSEC]" heading, but it doesn't cover XFRM docs yet. Add the entry.
> > 
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d652f4f27756ef..4f33daad40bed6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18041,6 +18041,7 @@ L:	netdev@vger.kernel.org
> >  S:	Maintained
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
> > +F:	Documentation/networking/xfrm/  
> 
> That means that I'm now responsible for this.
> But I'm OK with it if nobody has objections on it.

Definitely no objections :) 
Let me mark this series as "Awaiting Upstream".

