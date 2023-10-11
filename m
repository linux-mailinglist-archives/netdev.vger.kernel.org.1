Return-Path: <netdev+bounces-40061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210AD7C5976
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9C41C20ADC
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47757200B6;
	Wed, 11 Oct 2023 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBGQVdIm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0831B29B
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AB7C433C8;
	Wed, 11 Oct 2023 16:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697042823;
	bh=lCUotVjya7bI278C01F+y7PdmQnaCZWrDDjSWxDfe5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OBGQVdImWPXg446KhjqjdgzYxyQQum7vtNcAqHvoy8uKcX0a9LYvV7UGPM/zwaWfV
	 fpP8SqRX0ZFNPBZjhhTp8hApJTHJjksQM+zCJmRS1kFKMjfomoaB6bP4K3zZB4eFKG
	 qCdmQLhsHvrnnYXZyfU0kZ5k8l4kUYSTMjFLfJCklGwxA0g8VxiK2SQgRpgLUN84d6
	 itZhwsXY+rjYa1VJ8ZYaAiyxtv8zETLd1jFhNIzbA4dzd3Bo9GHN5nipvZrdaaTtWS
	 ltOyRWmDxkE9F+/W/9GEGzprM3FV8bf/Kn5eIYqS+ceQR5UqPmcT9cePAE3gBIrcmC
	 wcgwNhKraLiSg==
Date: Wed, 11 Oct 2023 09:47:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, johannes@sipsolutions.net
Subject: Re: [patch net-next 01/10] genetlink: don't merge dumpit split op
 for different cmds into single iter
Message-ID: <20231011094702.06ace023@kernel.org>
In-Reply-To: <ZSaGiSKL5/ocFYOE@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
	<20231010110828.200709-2-jiri@resnulli.us>
	<20231010114845.019c0f78@kernel.org>
	<ZSY7+b5qQhKgzXo5@nanopsycho>
	<ZSaGiSKL5/ocFYOE@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 13:27:05 +0200 Jiri Pirko wrote:
> >Yeah, we need fixes semantics written down somewhere.
> >I can do it, sure.  
> 
> I found 2 mentions that relate to netdev regarging Fixes:
> 
> Quoting Documentation/process/submitting-patches.rst:
> If your patch fixes a bug in a specific commit, e.g. you found an issue using
> ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
> the SHA-1 ID, and the one line summary. 
> 
> Quoting Documentation/process/maintainer-netdev.rst:
>  - for fixes the ``Fixes:`` tag is required, regardless of the tree
> 
> This patch fixes a bug, sure, bug is not hit by existing code, but still
> it is present.
> 
> Why it is wrong to put "Fixes" in this case?
> Could you please document this?

I think you're asking me to document what a bug is because the existing
doc clearly says Fixes is for bugs. If the code does not misbehave,
there is no bug.

