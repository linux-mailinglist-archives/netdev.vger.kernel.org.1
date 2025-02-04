Return-Path: <netdev+bounces-162441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 345FBA26EAE
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC141882A37
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A24207DE0;
	Tue,  4 Feb 2025 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE3s1T5B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE9207676
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661990; cv=none; b=CmN4o4aLzQoVX9jUPHHOetZnxlPUcaBfyVARgoA4hNM4E40giqSUIYOotd3Z9TVX9qy6ZctVyX3+PqSNtQafpKsBOURE8StFmQbQKwvU5Q0JKE1jSzo1BDvkXyiAJORph6JE5oTgwTDCswEM0rvzSb2DPksaDjyQQdT7CZXPxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661990; c=relaxed/simple;
	bh=A3HRjbEOJaU2P11eRHH6Suppazg1Uw6ciFV/wddELVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+oQtVd7BjlDtY4Fu6LgqeGgET/LMh9FfwbC1Q8OPwRhlpO6vwDnPIznf8QBYlNtQYq/iDuy9EjMbVf0m7U92ghB0auPK+R5pbVogy1YRz8DGTp2mob4lABkarfFQ88DINf6662czh/iCJvYC2OXXP5A7oHLzBUscUrYwhXT4vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE3s1T5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE5BC4CEDF;
	Tue,  4 Feb 2025 09:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738661989;
	bh=A3HRjbEOJaU2P11eRHH6Suppazg1Uw6ciFV/wddELVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HE3s1T5B5DGuSDxVNqHIt9XS89Bkb2J53ruK7gFTpNpBGPLTghlQXljWgvggELxoc
	 kNxsfHHDFkdfmlt09VA8WV9FNqqFW5PXOnXukpH/YnLWacyIDWbulxALAYQQOqOkf/
	 2CVvz1O/bBdpfJUy8BSzEowaANwXnBQY0hb6ZcWMB0TtEKe0zaTn95YLhCi08e2Jon
	 /Au3Wka6Zj7tgxipA585L7bcWHqZUWBSexDjJ913Ac35WIJGkLHiNKHNli56cQLfgN
	 UB14BHV92gJzlwjSiQmZviiYzHvH0kuYb9g+mikHKR9Vv7+4Kv2ELw6p5jkHWDbcnI
	 a3FhUQkY+8vJw==
Date: Tue, 4 Feb 2025 09:39:45 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH net 2/2] MAINTAINERS: add a sample ethtool section entry
Message-ID: <20250204093945.GM234677@kernel.org>
References: <20250202021155.1019222-1-kuba@kernel.org>
 <20250202021155.1019222-2-kuba@kernel.org>
 <20250203105647.GG234677@kernel.org>
 <9f6c2d87-bb45-4c95-af93-7d2ca5f1dcc3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f6c2d87-bb45-4c95-af93-7d2ca5f1dcc3@lunn.ch>

On Mon, Feb 03, 2025 at 02:29:23PM +0100, Andrew Lunn wrote:
> On Mon, Feb 03, 2025 at 10:56:47AM +0000, Simon Horman wrote:
> > On Sat, Feb 01, 2025 at 06:11:55PM -0800, Jakub Kicinski wrote:
> > > I feel like we don't do a good enough keeping authors of driver
> > > APIs around. The ethtool code base was very nicely compartmentalized
> > > by Michal. Establish a precedent of creating MAINTAINERS entries
> > > for "sections" of the ethtool API. Use Andrew and cable test as
> > > a sample entry. The entry should ideally cover 3 elements:
> > > a core file, test(s), and keywords. The last one is important
> > > because we intend the entries to cover core code *and* reviews
> > > of drivers implementing given API!
> > > 
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > ---
> > > This patch is a nop from process perspective, since Andrew already
> > > is a maintainer and reviews all this code. Let's focus on discussing
> > > merits of the "section entries" in abstract?
> > 
> > In the first instance this seems like a good direction to go in to me.
> > My only slight concern is that we might see an explosion in entries.
> 
> I don't think that will happen. I don't think we really have many
> sections of ethtool which people personally care about, always try to
> review across all drivers.
> 
> Even if it does explode, so what. Is ./scripts/get_maintainer.pl the
> bottleneck in any workflows?

Thanks Andrew,

I'm not overly concerned by the points I raised either, but I did think
they were worth raising.  And given that doing so didn't raise any alarm
bells (so far), I'm happy for this patch to proceed.

Reviewed-by: Simon Horman <horms@kernel.org>


