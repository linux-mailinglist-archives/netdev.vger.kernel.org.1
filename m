Return-Path: <netdev+bounces-39235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D357BE60B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5C3281870
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A6B38BAA;
	Mon,  9 Oct 2023 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ29Jtoe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C8838BA7
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 16:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CBDC433C9;
	Mon,  9 Oct 2023 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696867991;
	bh=cH3p2XB16xt8cfi0ACCBcCJO1/ReQtJfV6u5rTdQyII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UZ29Jtoe+UGhVqH6HrkaqPiKgMR7l5XFVpSkEQP5UqSLw3NgZgTaM03mZQfEeUt8J
	 rO9BkSNOzOPg46R2UsSOkPMkutvbEbTO4rCh1GP05SeVxwgm0cmOAtdqcFqh8pEi54
	 vfOqr6n+yuOXimSlpN/YXBk/bFM0ylut+OKSslEDAgjbpUNBLRytUZQ5zxTEni1mmV
	 R40H3EB+ZeQSm0llF3f7ITGv4yklQgNeW/bBezOAIbfSNusvat6o5p506J5Vm8KSqL
	 Y3ngJCEE1dF6bAjCP5uESW1Wfmr5gtLc7k8EsTSHmjW8S56lNdSpP6Ymwu0L4ItDG/
	 Ivrhn+tKxhxKw==
Date: Mon, 9 Oct 2023 09:13:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, <davem@davemloft.net>,
 <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <jesse.brandeburg@intel.com>, <sd@queasysnail.net>, <horms@verge.net.au>
Subject: Re: [RFC] docs: netdev: encourage reviewers
Message-ID: <20231009091310.7a6da97d@kernel.org>
In-Reply-To: <fad9a472-ae78-8672-6c93-58ddde1447d9@intel.com>
References: <20231006163007.3383971-1-kuba@kernel.org>
	<8270f9b2-ec07-4f07-86cf-425d25829453@lunn.ch>
	<20231006115715.4f718fd7@kernel.org>
	<20231006121047.1690b43b@kernel.org>
	<fad9a472-ae78-8672-6c93-58ddde1447d9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Oct 2023 17:13:45 +0200 Przemek Kitszel wrote:
> > Less experienced reviewers should avoid commenting exclusively on more
> > trivial / subjective matters like code formatting and process aspects
> > (e.g. missing subject tags).  
> 
> that should be taken for granted for experienced-but-new-to-community
> reviewer, but perhaps s/Less experienced/New/?

The set of Not new + Not experienced is not empty, right?
We want people to be cautious about posting such comments.
IOW what if people have been around for a while but aren't
very well versed in reviewing on netdev?

> > Sounds reasonable?  
> 
> yes!
> 
> other thing, somewhat related:
> I believe that I personally (new to community, ~new to Intel) would do
> "best" for community trying to focus most on our outgoing patches (so
> "pre-review" wrt. to netdev, but less traffic here).

Herm, yes, definitely. It's a separate topic, tho, because the folks
at Intel who will read the FAQ are also those who understand the
problems with the internal process. The problem is not new, to move 
the corporate processes we need metrics. I think.

> anyway,
> I feel encouraged here :)

Perfect :)

