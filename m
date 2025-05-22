Return-Path: <netdev+bounces-192664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D78AC0BD1
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C908F4A5351
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DEB28B40A;
	Thu, 22 May 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsO+SxOE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7C19DF66
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917831; cv=none; b=D2btQbtwstuJpmjXTxzuuG7wdwAorpGiExGmJlb+OAElpdxGHK6vuy1LVr2McWEo5TZ3CCVzFPHfXaTDCkJHTcaDzJk7SodC6NZduzISWG8xFyicP3vBTzgMmPpTeHew2NtPfKXOvGgh6qgoaP4zF1txvSJRqES99/tMjUIqzqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917831; c=relaxed/simple;
	bh=JGjLMwnCYCtC48rUmVq0iXJbsz3t9V7SV7xcLhWrprw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8PCxZINdnDMVCapBY4WOarBFTisFJMcju0wUwEm0bPMS4nILFIyVx1irfPKUojCjZ2vF502MbEaNoP68SoA7WZpIt3RAnxP891geWLTqY3PwnUtIjhjv+YmMTbGyNFZQ2mAcO8TM190S4qi5NUrCplmnIj+pbyL3DA+/gIHM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsO+SxOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37A3C4CEE4;
	Thu, 22 May 2025 12:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747917831;
	bh=JGjLMwnCYCtC48rUmVq0iXJbsz3t9V7SV7xcLhWrprw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsO+SxOEYKnVYk+0j8mPftvBmeCo2mSiftPhx/hI1WjH6mjirhXLKoOAXInG27R/G
	 yS4Y7MctiLIzMHLg0Q0efS9vfC2HJaAnRKnnDkqoV1MkJA540VGb3aM+XFcX4KmpmC
	 FyfFddqb3XSiyPi9yroYRkrhPCH+jJcyIpV/INECAxo/1fubGv2jbU3ydaccyNzg0C
	 HHtV9twNTcmdcKH//qtXwtHAyLew0rL/8/Xnesu2qUSnqQZk3BEmku6vAVyRy8L/sz
	 /dDmHZ5CXLQQ44MRzonv7yPWMzjOP5Q6iUExVZTna6LPhh/9ckB0fIOlDxQqrHFE27
	 fI1vYjCfINZyw==
Date: Thu, 22 May 2025 13:43:48 +0100
From: Simon Horman <horms@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] xsk: add missing virtual address conversion for
 page
Message-ID: <20250522124348.GZ365796@horms.kernel.org>
References: <20250521085633.91565-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521085633.91565-1-minhquangbui99@gmail.com>

On Wed, May 21, 2025 at 03:56:33PM +0700, Bui Quang Minh wrote:
> In commit 7ead4405e06f ("xsk: convert xdp_copy_frags_from_zc() to use
> page_pool_dev_alloc()"), when converting from netmem to page, I missed a
> call to page_address() around skb_frag_page(frag) to get the virtual
> address of the page. This commit uses skb_frag_address() helper to fix
> the issue.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

I agree that this is a fix for net-next. But as such I think it needs:

Fixes: 7ead4405e06f ("xsk: convert xdp_copy_frags_from_zc() to use page_pool_dev_alloc()")

Assuming that is correct then I don't think you need to repost just for
this. The tag should be picked up by automation by virtue of being present
in this email.

Reviewed-by: Simon Horman <horms@kernel.org>

