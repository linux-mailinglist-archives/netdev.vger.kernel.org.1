Return-Path: <netdev+bounces-194415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698F4AC958B
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 20:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9DB3B9B0E
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 18:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A552235360;
	Fri, 30 May 2025 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcPViu+F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541DF1A239D;
	Fri, 30 May 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748629054; cv=none; b=KW9vi2/NIYlHRvfaGmmKRAu9rVpwbtm/DyjOUmahW2j/l+/9qDOPySFkkSxDRghG3Cit9q9TI0SAHoWQU1rkgbDvWZGwJfVdTKug5OQgMQduOJgqcOutyqp36aznqmM0qtV+7Ep+UocCdUPPU1Xfe3oCUQG6ISupvFvSeGt7bm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748629054; c=relaxed/simple;
	bh=4NxsrPzw8oTEz9kqY00yHMFjULiR+Y78cPyCS5CldZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr2PMDgwyaL6tTASDVzxiMrnd1ETCvuC4lCYRyvfsULt5hsOZ/bte/UHksM9KmHwley74sTXHY/WxRnRAbHk+0ut4KIxTSF2gAlFiqcLeNHfbwASkKJ57vndS9I8//PyhbprCqu0BirbisokYxb/Bi9TmMWveRexDLKPZmM/8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcPViu+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8026C4CEE9;
	Fri, 30 May 2025 18:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748629053;
	bh=4NxsrPzw8oTEz9kqY00yHMFjULiR+Y78cPyCS5CldZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcPViu+F42gjYU+hGT7cxDnq5riWZgw2++DvOu8NyrIVPR8bHZmnO5RW0DmVXWVd1
	 ILl7W5TclLK36SDfFmU3dNwl1kJAq4jpIbe6hAMnUgoMhRK9wuoyTM6CgntaulRj9j
	 UjBPXCByoQ0CP90PniKiOL0YlCY/qIeR/5D0o+L39eNAGn0qQ9KsvWBTAgg6E9tWOA
	 Yp2G05NqlzGdN+kf1uTmILsEsbSmSw75Ns16kYHSomxss1Cvwebzuh76FzMkiiZ410
	 NhUxdLv5dG2HHMKFm/19PSh9brniYoTVajHunO7otFUhfApYAqzBXli4wWgNPFof5J
	 qOe64niRBxWCg==
Date: Fri, 30 May 2025 19:17:30 +0100
From: Simon Horman <horms@kernel.org>
To: Li Jun <lijun01@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ppp: remove error variable
Message-ID: <20250530181730.GU1484967@horms.kernel.org>
References: <20250530025040.379064-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530025040.379064-1-lijun01@kylinos.cn>

On Fri, May 30, 2025 at 10:50:40AM +0800, Li Jun wrote:
> the error variable did not function as a variable.
> so remove it.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>

Hi Li Jun,

Overall your patch looks good to me but as a cleanup for Networking
code it would be best to explicitly target net-next like this:

	Subject: [PATCH net-next] ...

But more importantly, net-next is currently closed, so please
repost your patch once it re-opens.

For reference, information on the development process can be found here.
https://docs.kernel.org/process/maintainer-netdev.html


## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.

-- 
pw-bot: defer

