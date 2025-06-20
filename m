Return-Path: <netdev+bounces-199633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B576AE1029
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 02:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF03C189CF0E
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 00:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A8C221562;
	Fri, 20 Jun 2025 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDiy9zYg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001AE1F3FD0;
	Fri, 20 Jun 2025 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750377608; cv=none; b=Qd3AoDCEpeWdoIw1/q9cCJRux9hihxcL0jNwa/czUqzB3rXkGmd7KD2Lt0rfyHngCuf0ZgqCY6soDas74oRHwS4T5ats/sSx4+OlDiYsqUZMxcdGFbIZfkseyUiMj3HsDcZbx+2ttxCm9AoscLZh2bCGGX0HNQcfcWY5wvvTLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750377608; c=relaxed/simple;
	bh=GqqOvGvUGKIWQTbjC45ma8+TYPkO9z1fomM2BMFdlZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdY3MOifCEyX9Mgl7657Nd+zBt6X+VEfyLMMDCLjx15Vzp7LTvx40CC+xIHidlNoWAgKdtkUHH5+efosS2qaxN/DNvXGIjQEIIprOuYBwcIJNefZrEsqhtDV4O6QMWiGUPXAAUgksnaznTJ1BIwylTsrbT3pMp97RTM4I0EOlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDiy9zYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF7BC4CEEA;
	Fri, 20 Jun 2025 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750377607;
	bh=GqqOvGvUGKIWQTbjC45ma8+TYPkO9z1fomM2BMFdlZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bDiy9zYgS9fk8PUWnyDlDsDQxlhwYxqMEqjT62cFBzg4keMpYLNEpC8l8ovJdeJud
	 73O2OD/uMZXyJdWbPGWO3gMotAh8bjgL+EeNVA6HsO3wlYgyn/5/TjdJSuGEw6VCxG
	 I1cNp2NQyY40mTwnubYhLBjm4e6z+dUMdwma4r8P5Kh484eQymevF47+9Tv53CQUS9
	 7ysW6hUZzzEPlPPml93UGefofQVTZAj2854jq5vK0E9i9EVrczcClorZR1K9GVXphJ
	 kZrji3gcGb2xP5TCynKaSJpn0wM7/O4hpIihNdmrKCx4l2n1bcJynghFCSUk7vwba/
	 hj53v6vdU5h/A==
Date: Thu, 19 Jun 2025 17:00:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v6.16-rc3
Message-ID: <20250619170006.5de19c70@kernel.org>
In-Reply-To: <175035530330.939772.7180274029359635736.pr-tracker-bot@kernel.org>
References: <20250619164054.1217396-1-kuba@kernel.org>
	<175035530330.939772.7180274029359635736.pr-tracker-bot@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 17:48:23 +0000 pr-tracker-bot@kernel.org wrote:
> The pull request you sent on Thu, 19 Jun 2025 09:40:54 -0700:
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc3  
> 
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/5c8013ae2e86ec36b07500ba4cacb14ab4d6f728

Heads up for people of netdev -- 
after forwarding the trees we now have the problem reported here:
https://lore.kernel.org/all/CAHk-=wgd=MdzRHO=bV=g0G0mMV+7ek-q2WnQ8P5sxwJdau-t=g@mail.gmail.com/
in our trees.

You may experience issues on x86 builds with CONFIG_MITIGATIONS_ITS
enabled. CI certainly hit it. We'll try to forward our trees again
once the fix is in Linus's tree.

