Return-Path: <netdev+bounces-119232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0B1954DF2
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC76FB21815
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD191BDA94;
	Fri, 16 Aug 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW1gLBdS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479AA1DDF5
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822740; cv=none; b=ae2oqSTuQ3MbsFtSquYw8YifHEZkHsDJ4hD2aJHrFOGqvf4fzuq9HpsUGaeIr0X/Y+XOVEG5NwuQCa3HKLEdcIok0UEc4gACH2487KfU75S1dxw8fKEqYZFyURp4EdMo7QrR864dTrIqWrwpUnl8jHRc4iz1bvmpWfaF4/vdinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822740; c=relaxed/simple;
	bh=GhLs8TY4+oNMGfEvoLDMC2UMMy3Ls/JD1JPeXHJp8DY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcHH3FsWnEm1WgxZxZTIVRNzfEKdcB5Oe+4eKNQG3TmdR/1QUaZDhh7iBEGgwGyhg2d4RyNEhilZJQ7Z71PuskcXFLgz3R1c93rtr305dPyahHO1I57vRTDbh7oEFZ/eSxAcqJP5KivpTr9+M789Pn8Im9DmrHoBEvpIhjcvWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW1gLBdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB53C32782;
	Fri, 16 Aug 2024 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723822739;
	bh=GhLs8TY4+oNMGfEvoLDMC2UMMy3Ls/JD1JPeXHJp8DY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aW1gLBdS+xkz5OeTv2ZT4b6d+sJQnBb4dO7XK3amXZZkd2IA38pfaQhh9TnxhbalW
	 KbInzr/u/nbmmk4GfpdNB6DPJP6OrSs7/Q6vxiKnirgPV+J0nIkpxAH523jRhh9H+s
	 6pDhft60EX2+38ti67Bd/1hjaWtyAgSutjVVxIhtfZHtWC/nmLqJ8mGEj3ZcBgEk7+
	 eGMO7CwsvO5OQlRZ6s4uRnnUjq/c/qm2nETWavhEL2VjmxqG9+LLhpXuYDspp9u+hk
	 QhV7XTFz8asoqW34dbg16ISQg7daKh1kD56i7+VNoB8SouNA6hAKwXjnbazr+Ldnjj
	 Gxy5QurWdgsbw==
Date: Fri, 16 Aug 2024 08:38:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Breno Leitao
 <leitao@debian.org>, Chas Williams <3chas3@gmail.com>, Guo-Fu Tseng
 <cooldavid@cooldavid.org>, Moon Yeounsu <yyyynoom@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH net 3/4] MAINTAINERS: Add header files to NETWORKING
 sections
Message-ID: <20240816083858.6fddd8ec@kernel.org>
In-Reply-To: <20240816132535.GA1368297@kernel.org>
References: <20240816-net-mnt-v1-0-ef946b47ced4@kernel.org>
	<20240816-net-mnt-v1-3-ef946b47ced4@kernel.org>
	<20240816132535.GA1368297@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 14:25:35 +0100 Simon Horman wrote:
> Sorry, net_shaper.h doesn't exist upstream, but must have in my local
> tree when I prepared this. I'll send a v2 in due course.

Any thoughts on using regexps more?

Like for instance:

include/uapi/linux/net_*

should cover existing missing cases, and net_shaper when it comes.

include/linux/netdev*

could be anther from the context of the quote.

