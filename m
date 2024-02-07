Return-Path: <netdev+bounces-69673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8EC84C21B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18624B28C30
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 01:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7B5D535;
	Wed,  7 Feb 2024 01:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B33E/tnu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543BA6110;
	Wed,  7 Feb 2024 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270249; cv=none; b=MHyAgPl0ojdEx1maRdiUCRTeDAnElW3Gf2wJHEBdbYa6rMu8ntUYVwoESyuzMBxdgrX9ufynOv+w7rLFvr+ZX859m/6QBK+KQ6wtuEcLgaz3lM0Zy7Hmd8UZWVETen/lgWh8Z4LmilI+0qiPxSQJNJf1XToAsGMRY0LnKBCDFO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270249; c=relaxed/simple;
	bh=VtLm8iXEQmPd78upVKjrBvCXxUUWtTQqhbFstC/uJ+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJxl4rUavezmkKLUj3hEGoWSbzxkOXamBPCVeUscNVrv4Z/MXUI799S60PZ+95VYbwiEgU3G342z9U0Astbvxek4R9Q7RwDd21p/65KLyAlCfSQsaw7a2pBareBSDT8mU9NgmAk3lYMr/eo0WkHS7E1u9Bkdb8qhr829Iryb47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B33E/tnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0686CC433C7;
	Wed,  7 Feb 2024 01:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707270248;
	bh=VtLm8iXEQmPd78upVKjrBvCXxUUWtTQqhbFstC/uJ+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B33E/tnu4crn5H1QOID/aUwJAPCk6yuDDleoHkde9VsH1vIvoeQ5JMMmB/W/GKW4Z
	 VxNZNKtT1YvrZwuS5H0tDPoZMHOrmT+ldMRHwD9Ra6uPzBjmWKJ872XPQ44km3769s
	 bUFMrD8PBesRCeZVVoSY0h3t1YiFEu9ajQnBtnPAgFpnaz4IDnE2BgmspWREZkLWo/
	 R4mlyFLaCMmx95lcozzmWCZIJSGjetiuiEz8ehQjkPP62YpqsDp/lANptueciVeK0m
	 HnsBIf4JdR3K9z9oF0dCfdaajkNvGJmd/D/ngcuAC5nke3hKwjvGArQut6dq3qrWdG
	 Vy/YETJrqqnig==
Date: Tue, 6 Feb 2024 17:44:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Mat Martineau
 <martineau@kernel.org>
Subject: Re: [TEST] The no-kvm CI instances going away
Message-ID: <20240206174407.36ca59c4@kernel.org>
In-Reply-To: <f6437533-b0c9-422b-af00-fb8a236b1956@kernel.org>
References: <20240205174136.6056d596@kernel.org>
	<f6437533-b0c9-422b-af00-fb8a236b1956@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 12:16:43 +0100 Matthieu Baerts wrote:
> Hi Jakub,
> 
> On 06/02/2024 02:41, Jakub Kicinski wrote:
> > because cloud computing is expensive I'm shutting down the instances
> > which were running without KVM support. We're left with the KVM-enabled
> > instances only (metal) - one normal and one with debug configs enabled.  
> 
> Thank you for the notification!
> 
> It sounds like good news if the non-support of KVM was causing issues :)
> 
> I think we can then no longer ignore the two MPTCP tests that were
> unstable in the previous environment.
> 
> The results from the different tests running on the -dbg instances don't
> look good. Maybe some debug kconfig have a too big impact? [1]

Sorry, I'm behind on the reading the list. FWIW if you want to reach me
quickly make sure the To: doesn't include anyone else. That gets sorted
to a higher prio folder :S

> For MPTCP, one test always hits the selftest timeout [2] when using a
> debug kconfig. I don't know what to do in this case: if we need to set a
> timeout value that is supported by debug environments, the value will be
> so high, it will no longer catch issues "early enough" in "normal"
> environments.
> Or could it be possible to ignore or double the timeout value in this
> debug environment?
> 
> Also, what is the plan with this debug env? It looks like the results
> are not reported to patchwork for the moment. Maybe only "important"
> issues, like kernel warnings, could be reported? Failed tests could be
> reported as "Warning" instead of "Fail"?

Unfortunately I'm really behind on my "real job". I don't have a clear
plan. I think we should scale the timeout by 2x or so, but I haven't
looked how to do that.

I wish the selftest subsystem had some basic guidance.

