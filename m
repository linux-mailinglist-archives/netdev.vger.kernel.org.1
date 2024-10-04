Return-Path: <netdev+bounces-132095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 417BC990615
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E65B21C80
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29549217337;
	Fri,  4 Oct 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPzjWtYa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0271A2178EE;
	Fri,  4 Oct 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052204; cv=none; b=iuN6OWd2CplIthIrPVFmLr/jf34UuX2X2ovbdwD7Z3A1ubkdDqu42G/16m7k/Sti0yx5LOv6I1XZURoUzhF/zbhd2HJFvLVoFot90kNA4SeWcZxMDqz5utj6oJZdL57ODOwks+Upmw25c07guQre+zFzkrtOgPHhfoa/BjjSD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052204; c=relaxed/simple;
	bh=bLKoNb2uB+6OkPrBQ+aR+U5ps5C4/rC8ma63QKADX8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uD90cQnaIMlDZqK9lsmIUt+srogWTayW7Y9ELH9TTxk+Lg3GQOxI52U2epn5s3no4plGudNY/yBBGdS62CpmHRrlfTOjWYDyvpvaULR8av7YK1OUdRKCnxH4tg+JslcXZEpOf2RtSLpYV1y+lmlbNVy0vliMnXvmZnxJmU4FwxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPzjWtYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE74C4CEC6;
	Fri,  4 Oct 2024 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728052202;
	bh=bLKoNb2uB+6OkPrBQ+aR+U5ps5C4/rC8ma63QKADX8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qPzjWtYa0SbKSDt3Aq5nATKbFB/82O4p2EVbIc+/dfslN2Vbm1baj3uMfcxoQdjee
	 vMW8Iuf8YRtaJmZDEkLZCk3EL6/aGbiZy4E8bLGdEwuPsFf28Ik8UgvkebXhKISQ4R
	 FxqUCEKT4e50771v/McZii9bFVp7zIJJMsJKQ2FOmYWjc6vdqjfiUSIL5HIl5N0Q77
	 TjTKepGqCdxDYcdNhrpY+1ZTmWwJqEGCMTBN09lRHIyrP1dsFojuj8Q7OrzgAiG6SJ
	 cjdFxVjiwF6ViRbj58jhulNzhItvRO1hSHn8UFxS4pF7Zb3b0Hz6cuorWO3HrhSTVa
	 c5KSQENx3XsSQ==
Date: Fri, 4 Oct 2024 07:30:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 thepacketgeek@gmail.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, max@kutsevol.com
Subject: Re: [PATCH net-next v4 00/10] net: netconsole refactoring and
 warning fix
Message-ID: <20241004073001.1316717d@kernel.org>
In-Reply-To: <20241004-shaggy-spectacular-moose-1b3bd6@leitao>
References: <20240930131214.3771313-1-leitao@debian.org>
	<20241003172950.65f507b8@kernel.org>
	<20241004-shaggy-spectacular-moose-1b3bd6@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 01:50:13 -0700 Breno Leitao wrote:
> > Makes sense in general, but why isn't the fix sent to net first, 
> > and then once the trees converge (follow Thursday) we can apply 
> > the refactoring and improvements on top?
> > 
> > The false positive warning went into 6.9 if I'm checking correctly.  
> 
> Correct. I probably should have separated the fix from the refactor.
> 
> For context, I was pursuing the warning, and the code was hard to read,
> so, I was refactoring the code while narrowing down the warning.
> 
> But you are correct, the warning is in 6.9+ kernels. But, keep in mind
> that the warning is very hard to trigger, basically the length of userdata
> and the message needs to be certain size to trigger it.

Understood, and to be honest it's a bit of an efficiency thing on
maintainer side - we try to avoid shades of gray as much as possible
because debates on what is and isn't a fix can consume a ton of time.

So in networking we push people to send the fixes for net, even if
triggering the problem isn't very likely.

