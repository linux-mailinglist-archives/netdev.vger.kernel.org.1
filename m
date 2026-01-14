Return-Path: <netdev+bounces-249742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DACA6D1D027
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 030673008E26
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A29337C0E9;
	Wed, 14 Jan 2026 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlhPj/Cd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442835F8AF;
	Wed, 14 Jan 2026 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377886; cv=none; b=FmgutUjRWZboBLd++K+K+bfjxNNcU7MfIgts/nyBfF9RIH9Vp02tOjyaFxtuLDGvJAxm5E8SWBa3RIxsJgHIfoHUtN6B/cXCQ7dT5je6TF0JP9m9H6+5SYHY1rAkPeIUWUgOygy1HUCBWDINlDw1jHi0OGOlWLq0k9inObiORmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377886; c=relaxed/simple;
	bh=teWN20ErRnFtv3ipS8RQd+DHv2eZXyLMY8Q+zMcAC9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLNq2WcI4zElN5PsKzHCjA1tEh6DbtSHRdGL9MK+1eRIf59rmQO2Lnod81EyN6I3prTPzR1eS2wvDlqZ5ZGMMf94QnZ5niUA2flmkmSvOAKTfmhchBNGid1qIUupeR31Gim2HJLoww6KUHjXLg/I4SCR0xM+TubMF6Dt2ctFuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlhPj/Cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36472C4CEF7;
	Wed, 14 Jan 2026 08:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768377885;
	bh=teWN20ErRnFtv3ipS8RQd+DHv2eZXyLMY8Q+zMcAC9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlhPj/CdsZpVwuqS9sYLhiBfxizD0sDhbtpCoZtuThoMEglisoP0wuV02Aeg1qDWY
	 iTBgcjjqRY3GY0VSfcYY9jbgc2VdAB2Pd3VCaw8MUDpRRsfmW7ds3AuQcOy/X/cCQT
	 EgfFSnef13TyQdm5OeUG4Vw9sNSmjUIzz2xCgiXfxamDjukHcmRyFGAB8x9H1OQAOV
	 rCqx0yo2RhSHU7oU/kKVIptXpLaSTBMzTs7dsYislI/+iH1h8j5r5vLmdmm3tB2rcB
	 rR3DWevVmcpd1aK2zUqjuzoWYq2uKZjh0C1nEjVwL2ysWdhLOmkBsqbUCD+FS8BKe0
	 3EydlRksfLQkA==
Date: Wed, 14 Jan 2026 08:04:41 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: netdev: refine 15-patch limit
Message-ID: <aWdOGUkpcNaxK-u9@horms.kernel.org>
References: <20260113-15-minutes-of-fame-v1-1-0806b418c6fd@kernel.org>
 <20260113173454.55a995cc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113173454.55a995cc@kernel.org>

On Tue, Jan 13, 2026 at 05:34:54PM -0800, Jakub Kicinski wrote:
> On Tue, 13 Jan 2026 17:47:15 +0000 Simon Horman wrote:
> > +Limit patches outstanding on mailing list
> > +-----------------------------------------
> > +
> > +Avoid having more than 15 patches, across all series, outstanding for
> > +review on the mailing list. This limit is intended to focus developer
> > +effort on testing patches before upstream review. Aiding the quality of
> > +upstream submissions, and easing the load on reviewers.
> 
> Thanks for adding this.
> 
> In practice I think the limit is also per tree (net vs net-next)
> to avoid head of line blocking fixes.

Thanks Jakub,

In v2 I'll update the wording to state that the limit is per-tree.

