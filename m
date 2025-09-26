Return-Path: <netdev+bounces-226704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B778DBA4347
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 022EF7BDC2D
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D235D202F7B;
	Fri, 26 Sep 2025 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgMT48U/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D791FBEB6;
	Fri, 26 Sep 2025 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896887; cv=none; b=DB+dodqm+n21hqqMiXtoIEXBUACX6ZH9Vh+xx5W6mvnUltyhpryHtDtpm6DNGgn4TsYyIQRWIWF8rXV5uWCh9eiqMciRgyLIQW/wyGDZw9Q8qCXtZd78o7pjYeh/RYpf/wpuglN3GLB/khLd0zdhLvgrZVNXxfFohPaKN0Cbq/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896887; c=relaxed/simple;
	bh=HpraTQNPQTkOuIgLJo+0IkraxdWBYMEppdjq9Zb6NWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAGnGxuubJtTWrL0bQf+sSKYE6XontUSYkQjcbxhzAzhblGvfmJWMbYPz73PxXtrpIj4/Y5OlOKOvLV1W1MOWkjPhfeTQhzEgCi+7dzhNi4UxkMEjBZb8/VhpgcJlT7eO9BvGxarljpu9ngcFUepIQ2BFNyd0Md2jQ23EQsmG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgMT48U/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BD3C4CEF4;
	Fri, 26 Sep 2025 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896887;
	bh=HpraTQNPQTkOuIgLJo+0IkraxdWBYMEppdjq9Zb6NWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZgMT48U/1MO9bkpaMDbfKd2teiEIvhNkJ2VWktBQnfN1u5fiGaSHFyEcTV1bbcWRY
	 0IAZAUfyOYwC81TrFTNgh/ZSg2DbG4QIgDgykF9M3efj/xwylPO5PUd1TlP0V1+Gyl
	 h6CrcYe+Gw0MBhQ4aQ7GOlyR/aQlfkNf7zJZC9CRa4f4HlxgImVVXDX3IuvMNedTIx
	 atdr4hCqgTGcarovjCHLwRqCZjHwX4tEGoGodrbfNigdRvIR5xf5u4Zjz/Nqhk51qy
	 r1uXgDiIPRpvq076PjoIvu23XH7F8BBO1cCXXOXfl45lhw7hu0ItX0Pyi2jts+A/g/
	 WGNu/kNy0GTwA==
Date: Fri, 26 Sep 2025 15:28:02 +0100
From: Simon Horman <horms@kernel.org>
To: Deepak Sharma <deepak.sharma.472935@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, pwn9uin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
	syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com,
	syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] atm: Fix the cleanup on alloc_mpc failure in
 atm_mpoa_mpoad_attach
Message-ID: <aNai8qxJV9rL9wWf@horms.kernel.org>
References: <20250925204251.232473-1-deepak.sharma.472935@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925204251.232473-1-deepak.sharma.472935@gmail.com>

On Fri, Sep 26, 2025 at 02:12:51AM +0530, Deepak Sharma wrote:
> Syzbot reported a warning at `add_timer`, which is called from the
> `atm_mpoa_mpoad_attach` function
> 
> The reason for warning is that in the first call to the ioctl, if
> there is no MPOA client created yet (mpcs is the linked list for
> these MPOA clients) we do a `mpc_timer_refresh` to arm the timer.
> Later on, if the `alloc_mpc` fails (which on success will also
> initialize mpcs if it's first MPOA client created) and we didn't
> have any MPOA client yet, we return without the timer de-armed
> 
> If the same ioctl is called again, since we don't have any MPOA
> clients yet we again arm the timer, which might already be left
> armed by the previous call to this ioctl in which `alloc_mpc` failed
> 
> Hence, de-arm the timer in the event that `alloc_mpc` fails and we
> don't have any other MPOA client (that is, `mpcs` is NULL)
> 
> Do a `timer_delete_sync` instead of `timer_delete`, since the timer
> callback can arm it back again
> 
> This does not need to be done at the early return in case of
> `mpc->mpoad_vcc`, or a control channel to MPOAD already exists.
> The timer should remain there to periodically process caches
> 
> Reported-by: syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=07b635b9c111c566af8b
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
> ---
> v2:
>  - Improved commit message
>  - Fix the faulty condition check to disarm the timer
>  - Use `timer_delete_sync` instead to avoid re-arming of timer
> 
> v1:
>  - Disarm the timer using `timer_delete` in case `alloc_mpc`
>    fails`

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

