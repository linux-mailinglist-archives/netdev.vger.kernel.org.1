Return-Path: <netdev+bounces-123210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D461964217
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949831C21593
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0724C148FE6;
	Thu, 29 Aug 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSjjKPSj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E47BA4D
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927930; cv=none; b=Bey/W2ri4aRanNqsoX2IcpBiZN8OeVaLuwsJ4cT972/kmuJHRxjctFD1vkD9n4nCBcSOUM5T6Wp2BKtmezAR4V6E68jK60Z2vlMG34MDISPSEsrh7uNBuh18C9Y0ymGxR3iy9ob2fWcbSgEmiwdaqf7pg5IfEbIUTCQoxuajAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927930; c=relaxed/simple;
	bh=6b8Uw9Jp+sjqcolbYbPOairpQpOfLBImKiNOjnC5Rk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXtqvE0+b6C7LCmboQRvMcJn5SLLTqos5YlfN53Ih7crsSTWmxbImKVX3TxkVagoZg/N8WUb/56PE1DazTeK9jrk7cGjsIKGG9KvshysdB7OLEunF+56C+FZ55ItnpBKocL3xhntMy+F4aSyz9bJ5umlmX48vgz77j1EdOUkHmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSjjKPSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025BAC4CEC1;
	Thu, 29 Aug 2024 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724927930;
	bh=6b8Uw9Jp+sjqcolbYbPOairpQpOfLBImKiNOjnC5Rk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSjjKPSjIqXnReidK90PKqIO6vL7vh5liswyLccrLUBeD5g7SOQDjLhLLG5NcaSFN
	 nqH9e63GPolyr/SF9VFG7LvLk1MykcHsSIf+AmQfrJg6B1sFEbf+B+qmVocheeCz9O
	 TyGzOL4BrH2gy0GsSiAsGu+X5y2DXZqZX9vW/SP3QeQpdgV8eXneJUETsVoVMpGM/V
	 3pg2niPWEweTGT7Y+hwJiUWb7mhSHn2PHPN7lLF9zSTXqsWJK6XGvRCT6uETT2O0+l
	 ENvRFznmpA9STiiFxc1GHcZD7mnwR0N0iM+qW/mh7Jkxr9zjQO/33S3Va1D5OkW/yM
	 Qm3ppudahWL0w==
Date: Thu, 29 Aug 2024 13:38:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	antony.antony@secunet.com
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20240829103846.GE26654@unreal>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240828112619.GA8373@unreal>
 <CADsK2K-mnrz8TV-8-BvBU0U9DDzJhZF2GGM22vgA6GMpvK556w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADsK2K-mnrz8TV-8-BvBU0U9DDzJhZF2GGM22vgA6GMpvK556w@mail.gmail.com>

On Wed, Aug 28, 2024 at 02:25:22PM -0700, Feng Wang wrote:
> Hi Leon,

Please don't top-post your replies when you are replying to a mailing
list. It makes it hard to follow the conversation.

> 
> Thank you for your insightful questions and comments.
> 
> Just like in crypto offload mode, now pass SA (Security Association)
> information to the driver in packet offload mode. This helps the
> driver quickly identify the packet's source and destination, rather
> than having to parse the packet itself. The xfrm interface ID is
> especially useful here. As you can see in the kernel code
> (https://elixir.bootlin.com/linux/v6.10/source/net/xfrm/xfrm_policy.c#L1993),
> it's used to differentiate between various policies in complex network
> setups.

Which in-kernel driver use this information?

> 
> During my testing of packet offload mode without the patch, I observed
> that the sec_path was NULL. Consequently, xo was also NULL when
> validate_xmit_xfrm was called, leading to an immediate return at line
> 125 (https://elixir.bootlin.com/linux/v6.10/source/net/xfrm/xfrm_device.c#L125).

It is intentional, because the packet is forwarded to HW as plain text
and it is not offloaded (doesn't have xfrm_offload()).

> 
> Regarding the potential xfrm_state leak, upon further investigation,
> it may not be the case. It seems that both secpath_reset and kfree_skb
> invoke the xfrm_state_put function, which should be responsible for
> releasing the state. The call flow appears to be as follows: kfree_skb
> -> skb_release_all -> skb_release_head_state -> skb_ext_put ->
> skb_ext_put_sp -> xfrm_state_put.

You are trying to make same flow as for crypto, but it is not the same,
in crypto case secpath_reset() was called to release SKB extensions and
perform cleanup, first and only after that new xfrm_state_hold() was
called, but in new code SKB is not reset.

Thanks

> 
> Please let me know if you have any further questions or concerns. I
> appreciate your valuable feedback!
> 
> Feng
> 
> On Wed, Aug 28, 2024 at 4:26 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Aug 28, 2024 at 07:32:47AM +0200, Steffen Klassert wrote:
> > > On Thu, Aug 22, 2024 at 01:02:52PM -0700, Feng Wang wrote:
> > > > From: wangfe <wangfe@google.com>
> > > >
> > > > In packet offload mode, append Security Association (SA) information
> > > > to each packet, replicating the crypto offload implementation.
> > > > The XFRM_XMIT flag is set to enable packet to be returned immediately
> > > > from the validate_xmit_xfrm function, thus aligning with the existing
> > > > code path for packet offload mode.
> > > >
> > > > This SA info helps HW offload match packets to their correct security
> > > > policies. The XFRM interface ID is included, which is crucial in setups
> > > > with multiple XFRM interfaces where source/destination addresses alone
> > > > can't pinpoint the right policy.
> > > >
> > > > Signed-off-by: wangfe <wangfe@google.com>
> > >
> > > Applied to ipsec-next, thanks Feng!
> >
> > Stephen, can you please explain why do you think that this is correct
> > thing to do?
> >
> > There are no in-tree any drivers which is using this information, and it
> > is unclear to me how state is released and it has controversial code
> > around validity of xfrm_offload() too.
> >
> > For example:
> > +               sp->olen++;
> > +               sp->xvec[sp->len++] = x;
> > +               xfrm_state_hold(x);
> > +
> > +               xo = xfrm_offload(skb);
> > +               if (!xo) { <--- previous code handled this case perfectly in validate_xmit_xfrm
> > +                       secpath_reset(skb);
> > +                       XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
> > +                       kfree_skb(skb);
> > +                       return -EINVAL; <--- xfrm state leak
> > +               }
> >
> >
> > Can you please revert/drop this patch for now?
> >
> > Thanks

