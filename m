Return-Path: <netdev+bounces-97610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF58CC54B
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE021F21179
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD4D56773;
	Wed, 22 May 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l74wTZv0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99401F17B
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397446; cv=none; b=D+weekUZHwFHyCAG5+P0Dn6UeLIuwYM6IoLVgQgD8zp2uHOajjHEo/7zdfXrfDh3sXXFP805Lc8KE+YKwc1I9bPnjU1izFmgxxH7hYWe0OeIsfcYrk/ENVAWjPtRIBVN8MBWJjuEEEYkbOjFCB7KfLCqPdv97I2af72tY4f9wBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397446; c=relaxed/simple;
	bh=fdUPH0V1XmDR09nXntX63sgvijubm8iHgJvlx4MPcvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpJWje6iAyosxw5hRTvuBwPbuMCXt2M01HBNjNIAFZhIyCljH/kFEfKR6dmusXVvDrNg2QbYvMzT7JeteJwldrJSQdk5YfAR83o0f7UM7yIKk5wu3IVmBvsmsSWLdGikiq4avdykSOz4IXGMJwf+tUw+Ub8yEK9F6+1EAJ2XF+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l74wTZv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4052C2BBFC;
	Wed, 22 May 2024 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716397446;
	bh=fdUPH0V1XmDR09nXntX63sgvijubm8iHgJvlx4MPcvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l74wTZv0ur2Gl1zcENGNn9EU7D9/87isq2uesaqmN4E4yLfQ+06dDKkyHlG2tTb4N
	 uYH+8XN9NMTeKp05HpxgG9MMdBXLzYZWeeeYKA+9nYpKRugG9CQ6/YNln49c5eRW/l
	 i567Sl72j2IxTWWyagU8PZ+7V7YmOUdsaHTc93pGtuNC3EQd+gWZRFKeZ4NMmopBLe
	 HNSXPzE4xmJhPacC33iyDxoPCHw4fSB+W1zosi0aVvdLqAPUz+my+Bct3aFJUXqIqF
	 PiNYgfo8CwCXSN4Y3CTzhTHS8TrIuT/ck60lvZEF33iCtAhbsQ463viVrb+3faVExe
	 xYomomSGCy8iA==
Date: Wed, 22 May 2024 10:04:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 brett.creeley@amd.com, drivers@pensando.io
Subject: Re: [PATCH net 0/7] ionic: small fixes for 6.10
Message-ID: <20240522100404.230e4bab@kernel.org>
In-Reply-To: <e68cf441-e877-4cf8-98c6-86b6067364a8@amd.com>
References: <20240521013715.12098-1-shannon.nelson@amd.com>
	<20240521140631.GF764145@kernel.org>
	<e68cf441-e877-4cf8-98c6-86b6067364a8@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 May 2024 10:14:24 -0700 Nelson, Shannon wrote:
> As always, thanks for taking a look at the set.
> 
> All of these patches are fixing existing code, whether by cleaning up 
> compiler warnings (1, 7), tweaking for slightly better code (3, 4), 
> getting rid of open coding instances (5), and fixing bad behavior (2,6). 
>   It seems to me these fit under the "fixes to existing code" mentioned 
> in our Documentation/process/maintainer-netdev.rst guidelines.

I think that's a stretch, Simon is right. Maybe we can take patches 
1 and 7 without the Fixes tag, just to make your life easier.
But if the rest are fixes I wouldn't know what isn't..

