Return-Path: <netdev+bounces-128081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BA6977E26
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E9828660B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C6E1D6C63;
	Fri, 13 Sep 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYx3FFK4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4993716D
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726225434; cv=none; b=olMEu1kTsORc4WQdBCA8SvYfYPJmiV8zlpMxrw05kC3VIh9CuCWzSCzbW6pEkjLFGZ5zRKRUdtWGXyhJLS77WCq/Lt0BvbLEffQ4g212xlXaX7KRcLSW1w3ltGHW4mFqyWOs3PPYff3Q3U/nlKfG0tfzHSdgPLrLXU4ZPY+D6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726225434; c=relaxed/simple;
	bh=LlMXeuOD8txDW1XNN/I59PnCgww442jRUoUyQWJxjkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP/dH3X0mCtqHi58krVBJdFkIjqbwVeOQyaLJGU88OuRGrbtNI68zH6o97Q/PwbyvnrF15l/MEjDDmRxpqzhnSzw2kgt7kn4br3z/Pmal/YuE3F8tnKu5cIULAOJNzFMbtpBtZsDK71L9HSIA+i+xvBjP67VwD/4Id3OLOxHfQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYx3FFK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE24C4CEC0;
	Fri, 13 Sep 2024 11:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726225434;
	bh=LlMXeuOD8txDW1XNN/I59PnCgww442jRUoUyQWJxjkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYx3FFK46Atcz3LKxkZcLswK8k6A8ehkIg1ZGBLMQZlV31MWYUa9TGxD7Z8uaYl/2
	 gvt0EWpnefZKyYE4KiTj3ICqAzH3Jvxq71KuC0JU/Edw4P2i5T8/xPdQ+rMb8EWAUQ
	 5byXIs59L9x+IvpdcaWAw+OtTIPbU8WFSqoL2AFW3E5CtUnFb4RdAGKoj7/zWIp41/
	 +PTDAz1mRUXHI5qSvZvbyUkWZzk/cUSOm52PnPf/wrxiLIZrCcRvXvukGCyyeARrL5
	 Z0N1rT55iYJ0WCv0WJnZrbSDC6dJjEQvNqBG6ryGtY3ZzI2pYoD76mRTnzcHWjkBQ/
	 D9m3qZzCvdmZQ==
Date: Fri, 13 Sep 2024 12:03:50 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: Re: [PATCH net-next] net: sched: cls_api: improve the error message
 for ID allocation failure
Message-ID: <20240913110350.GU572255@kernel.org>
References: <20240912215306.2060709-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912215306.2060709-1-kuba@kernel.org>

On Thu, Sep 12, 2024 at 02:53:06PM -0700, Jakub Kicinski wrote:
> We run into an exhaustion problem with the kernel-allocated filter IDs.
> Our allocation problem can be fixed on the user space side,
> but the error message in this case was quite misleading:
> 
>   "Filter with specified priority/protocol not found" (EINVAL)
> 
> Specifically when we can't allocate a _new_ ID because filter with
> lowest ID already _exists_, saying "filter not found", is confusing.
> 
> Kernel allocates IDs in range of 0xc0000 -> 0x8000, giving out ID one
> lower than lowest existing in that range. The error message makes sense
> when tcf_chain_tp_find() gets called for GET and DEL but for NEW we
> need to provide more specific error messages for all three cases:
> 
>  - user wants the ID to be auto-allocated but filter with ID 0x8000
>    already exists
> 
>  - filter already exists and can be replaced, but user asked
>    for a protocol change
> 
>  - filter doesn't exist
> 
> Caller of tcf_chain_tp_insert_unique() doesn't set extack today,
> so don't bother plumbing it in.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


