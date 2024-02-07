Return-Path: <netdev+bounces-69672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF46F84C1F2
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B9BFB2402C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 01:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486B346B1;
	Wed,  7 Feb 2024 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCOC9kka"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AAFBE9;
	Wed,  7 Feb 2024 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707269828; cv=none; b=AreLHfcqJJ258joR5Cxic0/m026uQFUv3rtVaUDkweilC3x6yQCrCI8c4DkwlnoEr4FbfuyhX2nPweV9jtgWk/ZGU7wTijMidog3Drk/qWzlh5x2I4PtD7jdnTuvI+5oh/jGtYtWZlLT9O24YjvQRwgJysmbX58EqbLe+2nEFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707269828; c=relaxed/simple;
	bh=5EKdeJd7hLSZua52syw/apXSV4DJ7iUDO8Ukyigp1vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6cgOjHnUzJ7VlbYWKGOpZSf4749C0muu7/Q1521YC1IEGLLrI6vlB49Lp+nwdveWWPKgjGN7b0VXowQTf8jOFui25OXaJPjNKOQY/WRuk44H1JywmwgcZgbD43dBL3dsUqJDzNBmItaDn0b+S+rlc5tCaj7bFMgLMJ8kmyqo10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCOC9kka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610D0C433C7;
	Wed,  7 Feb 2024 01:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707269826;
	bh=5EKdeJd7hLSZua52syw/apXSV4DJ7iUDO8Ukyigp1vQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZCOC9kkaFj+56azpNEKw8NRiJj8W8XzEpQLVeCx+UGGSN//NKdPBx0YFQ2IZxqfY0
	 ymDB4FGZtDXsl8yV5aakIq5+Rc/MvNgpu8qhbuLtFXYWr9AH+O2WXh+GbhC4ma6W8o
	 iP11NnC9K02E/xjP217X3Z6KFPK1g1GoZy4PEmDV9TlB8HCXC++qFOQMwbhHzo3YE5
	 81fzwVs4uSCP9xfeDos4aA+nx1VtqQc3D2d+VjN8fhpvd7utW7KNFq0BKk/SNpMAJV
	 RwlGKIEBBnqvJ2yKNfjgJ5UJOQ0afSQ7Qxh3jVamb/Z76QYqYli0sVMLeqgj1DRQaL
	 iCKHDu1tb5BRA==
Date: Tue, 6 Feb 2024 17:37:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [TEST] Wiki / instructions
Message-ID: <20240206173705.544f4cb2@kernel.org>
In-Reply-To: <90c6d9b6-0bc4-468a-95fe-ebc2a23fffc1@kernel.org>
References: <20240202093148.33bd2b14@kernel.org>
	<90c6d9b6-0bc4-468a-95fe-ebc2a23fffc1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Feb 2024 18:21:56 +0100 Matthieu Baerts wrote:
> Thank you for this wiki page, and all the work with the CI infrastructure!
> 
> For the debug options, I see that you are using:
> 
>   kernel/configs/x86_debug.config
> 
> It looks like this is specific for the 'tip' tree:
> 
>   Debugging options for tip tree testing
> 
> I don't know if it is still maintained, e.g. it includes DEBUG_SLAB
> option. But also, it enables options that are maybe not needed: GCOV?
> X86_DEBUG_FPU?
> Maybe it is better not to use this .config file, no?

I haven't looked to closely. I noticed that the basic debug config
doesn't enable LOCKDEP ?! so I put the x86 one on top.

I added a local patch to cut out all the obviously pointless stuff from
x86_debug.config, we should probably start our own config for networking
at some stage.

> For our CI validating MPTCP tests in a "debug" mode, we use
> "debug.config" without "x86_debug.config". On top of that, we also
> disable "SLUB_DEBUG_ON", because the impact on the perf is too
> important, especially with slow environments. We think it is not worth
> it for our case. You don't have the same hardware, but if you have perf
> issues, don't hesitate to do the same ;)

The mptcp tests take <60min to run with debug enabled, and just 
a single thread / VM. I think that's fine for now. But thanks for 
the heads up that SLUB_DEBUG_ON is problematic, for it may matter for
forwarding or net tests.

