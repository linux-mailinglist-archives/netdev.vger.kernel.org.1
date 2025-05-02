Return-Path: <netdev+bounces-187401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C08AA6E4D
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060CF4A8144
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3CD231847;
	Fri,  2 May 2025 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHvO5rj+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03B230BC1;
	Fri,  2 May 2025 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178719; cv=none; b=cMiayONaY5o6XKC+c6xdjHdlMrZwuF6+3fNTwULRCGbudjWyyxKGMcmWLsiZhtBKMIIgDLKPN5jcYEBX4jIlRC8X9bcep0LRI+dF+Tno/gXWJGXtqvRB6OOuzLoUjlRJfBHGzDDsQNmC1i6KJJARBKEuJvTUwtYO/2g8z6FHzO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178719; c=relaxed/simple;
	bh=483Q7qnwpLcl47JF+JXmvN5ttybKP87+NHEoVqWBjbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNTLlYgPKml2F0jEXzea2jvTNs1YPuCO9ZXwNpjLsEhsAVxYSYxfj0q0cD8cquf/8zs+LayUgVk6aaOLUs6DD7kStIigbeB8dy+6MbCFSy0DRnkHjBnGPUa8qKMnHrvaCu2ru+fYiKWgr+oB+bXvi4/yTOWC4rlRxbIVP0iMM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHvO5rj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9C7C4CEE4;
	Fri,  2 May 2025 09:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746178718;
	bh=483Q7qnwpLcl47JF+JXmvN5ttybKP87+NHEoVqWBjbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHvO5rj+/qYr7b3wtyLuRGK5epJF3jHRdmBE7D3J03dFXa3v8NRJ7D1AoPUMmS/Us
	 lj+7r7+Ye9F22zjqeox9szuugoO0L6PhSZm3eSQP7AgmsP9dQJTaQRZtwcUCR2UC9b
	 Q90ZPbeqGuTH28Jh7Py2mxfW6lbnV0xbkRpTT+BUZhAoQ1ZZWLQO2wBB7DssIX+/tT
	 vls7bFlbHDiMKM29F6nj1PY1oG3C5vGx9Ae+TdCnaHy7StdHFibnXIQbx/dVWgMXRA
	 ZiJ+mLKsoyBzi4jKyvFVUSKQPNcRssPiBIakt8pGNdjhIFghMPGneFEdnpXoGFwDUU
	 3L9HJo/6pkoCg==
Date: Fri, 2 May 2025 10:38:33 +0100
From: Simon Horman <horms@kernel.org>
To: Ruben Wauters <rubenru09@aol.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipv4: ip_tunnel: Replace strcpy use with strscpy
Message-ID: <20250502093833.GF3339421@horms.kernel.org>
References: <20250501012555.92688-1-rubenru09.ref@aol.com>
 <20250501012555.92688-1-rubenru09@aol.com>
 <20250501153956.GC3339421@horms.kernel.org>
 <9fab7b2389d43e0800024a431bd7736f22062f06.camel@aol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fab7b2389d43e0800024a431bd7736f22062f06.camel@aol.com>

On Thu, May 01, 2025 at 05:51:08PM +0100, Ruben Wauters wrote:
> On Thu, 2025-05-01 at 16:39 +0100, Simon Horman wrote:
> > On Thu, May 01, 2025 at 02:23:00AM +0100, Ruben Wauters wrote:
> > > Use of strcpy is decpreated, replaces the use of strcpy with
> > > strscpy as
> > > recommended.
> > > 
> > > I am aware there is an explicit bounds check above, however using
> > > strscpy protects against buffer overflows in any future code, and
> > > there
> > > is no good reason I can see to not use it.
> > 
> > Thanks, I agree. This patch doesn't buy us safety. But it doesn't
> > lose
> > us anything. And allows the code to move towards best practice.
> > 
> > One thing I notices is that this change is is inconsistent with the
> > call to
> > the 3-argument variant of strscpy a few lines above - it should also
> > be hte
> > 2-argument version. Maybe that could be changed too. Maybe in a
> > separate patch.
> 
> 
> I can remove the size parameter from the above strscpy to make it
> consistent in v2.
> 
> > It is customary when making such changes to add a note that
> > strscpy() was chosen because the code expects a NUL-terminated string
> > without zero-padding. (Which is the case due to the call to
> > strcat().)
> > Perhaps you could add some text to the commit message of v2 of this
> > patch?
> 
> Apologies, I wasn't aware of this, I can add the text to v2.
> 
> Just a point of clarification I wanted to ask, for v2 of the patch,
> should I include the Reviewed-by tag below? or should I remove it as
> there has been changes?

I think you can include it unless the changes turn
out to be materially different to what has been discussed
in this thread.

But if in doubt, drop it.

> 
> 
> > > Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>

...

