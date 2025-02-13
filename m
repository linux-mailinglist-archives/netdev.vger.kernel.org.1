Return-Path: <netdev+bounces-166183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A594A34DEC
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACAE16C8E7
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15892063E2;
	Thu, 13 Feb 2025 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD5ifBeD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9DC28A2D4
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472379; cv=none; b=VsbLKN+YNciD8hnx6XU+miew2DODDE+5JT/iZbRNARAL7izwnWljaZ4mzUvIg6sFp/fPduaH8yYZ3w8MYf/MKn1CMWGVvz/k+OInfbyuXLZLUVfmS7WcHsz81W26tWFzixnvvn/qpZuoMOyROgt/+A1LRCXAeNsdoDeWh6D3s+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472379; c=relaxed/simple;
	bh=8hjTbEcZWTae8o4fJVkls1VinnjQkyW3VGPdKTL37hE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGuIBbEjSEKSV3f7nbwhZkItiPA+CNRGCsY+lJCC6Bk5jPu5LSbGV6u13Xu0hPW6Xrw9NGTE8KFXIGVI8JgCTpZ62sz3DMr9i7otteQnl/ag4eZDdxnxtdDzuvKYAT+Hc5ZsQgN3ZSDOQix6ZoaBYmiS8dvblgcXIlNDOvQcM9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RD5ifBeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D40C4CEE5;
	Thu, 13 Feb 2025 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739472379;
	bh=8hjTbEcZWTae8o4fJVkls1VinnjQkyW3VGPdKTL37hE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RD5ifBeD/8MHfU3P/ZrnsRfm2meBQzOSYIHWC1yU2WIvzznUMszU9J0nqe2h242b4
	 tOiy/mGAsBwtbHzsP2X6R8cYKkcwetrVHtGETyL8sWVQwYtL7A8zrBERhrkChKirsj
	 R+Q/RRwIFEWk9cetqtGgychvWBAFguKShlNC2Z/Cs1etuG7wcSQP4YvABvbg+PyOkz
	 4DWZTq6KLkhCPvUTq9M5AFGvnSEsDnDe1lGNn0kxaXBdoqkrn+bakWoF3oJYy8Rhix
	 ylgfNLzQHBZtHMsjCcwng7bzHEhj3v1IyIiz+Xtd3KGhisYt2lOpi9YBuqTSFKrm6V
	 gem11+n5ijQcA==
Date: Thu, 13 Feb 2025 10:46:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Berg, Benjamin" <benjamin.berg@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [TEST] kunit/cfg80211-ie-generation flaking ?
Message-ID: <20250213104618.07d9a5fe@kernel.org>
In-Reply-To: <dd9fa04ea86c2486d6faba1eff20560375c140b6.camel@sipsolutions.net>
References: <20250213093709.79de1a25@kernel.org>
	<dd9fa04ea86c2486d6faba1eff20560375c140b6.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 19:22:04 +0100 Johannes Berg wrote:
> > We hit 3 failures in the last 3 days.  
> 
> Four, actually, it seems? ;-)

Yup! I jinxed it, it failed again after I sent the report :)

> > https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=cfg80211-ie-generation
> > 
> > But the kunit stuff likes to break because of cross-tests corruptions :(  
> 
> Hmm. Let's say ...
> 
> https://netdev-3.bots.linux.dev/kunit/results/987921/kunit-test.log
> 
> is your serial console simply too slow?
> 
> ok 70 cfg80211-inform-bss
>     KTAP version 1
>     # Subtest: cfg80211-ie-generation
>     # module: cfg80211_tests
>     1..2
>         KTAP version 1
>         # Subtest: test_gen_new_ie
>         oaction: accept multicast without MFP
> 
> should say
> 
> "ok 4 public action: accept ..."
> 
> instead, I think?

Oh, that's annoying :( Thanks for investigating.
I think the CI runs when the machine is overloaded by builds.
I'll add some safety for that.

