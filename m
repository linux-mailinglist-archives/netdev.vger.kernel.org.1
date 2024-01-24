Return-Path: <netdev+bounces-65517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D6683AE43
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009F91C20F70
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF14B7C094;
	Wed, 24 Jan 2024 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snEVuu9u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295D7CF22;
	Wed, 24 Jan 2024 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113377; cv=none; b=IrfhccKRe4oQj1wNkbjfk2oXw2gRLcZg954WNhOW8SAnrk8F6GmqAv/u6jGDU9yRm1N4cwsFahqnjAX0Ev39GU+pA5hgwS0bvMWz/0niB7pyFo9bJsNUolL91cejKG2O8NNN27gbXAdDcMXSl1J2m/4CWek/jHFZkTw8HxshA5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113377; c=relaxed/simple;
	bh=ARMOd4c5hLEULlHQs+isp/MiD5vLVcM/OwLD6pl5n2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoyXgGv6VX8vA7TBkNbe1d+VK5kpY7wt71qtfUldVayuQ9hwnBU6uk5YQKQ2V7hbGSIlfjA6BPv1xW8bPrqAHgQnCc/yJ2B+A83MvJj9sZdCQA2U6VFc5djeeoaTap4tP7MamAfnMES+0uR8P1HrSTpfWPpVXK9l0+/1YD4UYOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snEVuu9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B69C433F1;
	Wed, 24 Jan 2024 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706113377;
	bh=ARMOd4c5hLEULlHQs+isp/MiD5vLVcM/OwLD6pl5n2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=snEVuu9u4JcPwas0vGvzvXBc2VMUr+kL2JhdY+UaQcAfaR9H/buP9XXpjSEFos5eF
	 pcTv5pj4XfcjCk9Q8YSK/GvhuKY2cueq/2Hkb5824EvNZ8OlOXb1m39Zw1Uo9YlZyz
	 ca0nLLVlapia3OvKDyehdJr1P1Hj/3dAmODBaH4XKz5hBBkXOHF/YICZ87zj9TwWRu
	 k5KG76HQLnIuSByYPrRDGONrceg9skneNq/0vYtZUjiiFYcBjEwVOMMlVBlLXl38sC
	 Rxk+HkHoMeujQjA/JfYxlS4dW8rJDfIU7laru5II07xIJBUEdVQW6uiWGjSNbWybqD
	 ektV5d0jOvqsA==
Date: Wed, 24 Jan 2024 08:22:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240124082255.7c8f7c55@kernel.org>
In-Reply-To: <65b133e83f53e_225ba129414@willemb.c.googlers.com.notmuch>
References: <20240122091612.3f1a3e3d@kernel.org>
	<Za98C_rCH8iO_yaK@Laptop-X1>
	<20240123072010.7be8fb83@kernel.org>
	<d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
	<65b133e83f53e_225ba129414@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 10:59:36 -0500 Willem de Bruijn wrote:
> David Ahern wrote:
> > On 1/23/24 8:20 AM, Jakub Kicinski wrote:  
> > > It groups all patches outstanding in patchwork (which build cleanly).
> > > I'm hoping we could also do HW testing using this setup, so batching
> > > is a must. Not 100% sure it's the right direction for SW testing but
> > > there's one way to find out :)
> > >   
> > 
> > Really cool. Thanks for spending time to make this happen.  
> 
> Just to add to the choir: this is fantastic, thanks!
> 
> Hopefully it will encourage people to add kselftests, kunit tests or
> other kinds that now get continuous coverage.

Fingers crossed :)

> Going through the failing ksft-net series on
> https://netdev.bots.linux.dev/status.html, all the tests I'm
> responsible seem to be passing.

Here's a more handy link filtered down to failures (clicking on 
the test counts links here):

https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-01-24--15-00&executor=vmksft-net-mp&pass=0

I have been attributing the udpg[rs]o and timestamp tests to you,
but I haven't actually checked.. are they not yours? :)

