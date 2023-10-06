Return-Path: <netdev+bounces-38661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 818207BBF98
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 21:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C5F2820A9
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 19:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF823C684;
	Fri,  6 Oct 2023 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck7obc6Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2323AC2E
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 19:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC34C433C8;
	Fri,  6 Oct 2023 19:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696619448;
	bh=BLwlxzNy2jPDF5oRpPNcwVy5X2uDz8Wu1nmUCZHeK1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ck7obc6Y/SQ/rbF4e+BWL6wVdhRuT0gd8QxIQYXqm+mFbeqoqUCo1W7D7tYwx4YJM
	 AB//cOu5LTC9W1zqONOhBm5pXb+5vXzeNCOoiHFPKHlt5hm8YFgs86GLL7akM+ioOb
	 93aiBXpbMWPFSuTtSKHXBQjdJt7Pjexb7LjRq1uyBk5fLRu43+B8iGy1bRq8PDn7Ut
	 bO6t9gWLXS2+HpV/KQ1owqkdcb6kAhNf/+0FOSeh3iNY/LE3Pv55m/xEbJEiHJP+XL
	 TjaGUKrCFyMXzxFAIh3o7SEhBFV1X2bDBgpfYfBUtlLnc2G9o2ef0bj7zC3zCPofBV
	 S/LZYecdFrcXA==
Date: Fri, 6 Oct 2023 12:10:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jesse.brandeburg@intel.com, sd@queasysnail.net,
 horms@verge.net.au
Subject: Re: [RFC] docs: netdev: encourage reviewers
Message-ID: <20231006121047.1690b43b@kernel.org>
In-Reply-To: <20231006115715.4f718fd7@kernel.org>
References: <20231006163007.3383971-1-kuba@kernel.org>
	<8270f9b2-ec07-4f07-86cf-425d25829453@lunn.ch>
	<20231006115715.4f718fd7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Oct 2023 11:57:15 -0700 Jakub Kicinski wrote:
> :) If I can't get it past you there's no chance I'll get it past docs@
> 
> Let me move some of the staff into general docs and add a reference.
> The questions which came up were about use of tags and how maintainers
> approach the reviews from less experienced devs, which I think is
> subsystem-specific?

So moved most of the paragraphs to the common docs, what I kept in
netdev is this:


Reviewer guidance
-----------------

Reviewing other people's patches on the list is highly encouraged,
regardless of the level of expertise. For general guidance and
helpful tips please see :ref:`development_advancedtopics_reviews`.

It's safe to assume that netdev maintainers know the community and the level
of expertise of the reviewers. The reviewers should not be concerned about
their comments impeding or derailing the patch flow.

Less experienced reviewers should avoid commenting exclusively on more
trivial / subjective matters like code formatting and process aspects
(e.g. missing subject tags).


Sounds reasonable?

