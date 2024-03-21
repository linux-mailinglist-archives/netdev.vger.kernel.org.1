Return-Path: <netdev+bounces-80986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D0488568F
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 10:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C671F232E5
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D7047F58;
	Thu, 21 Mar 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ef2qCtNU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95EC20326
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013572; cv=none; b=XOj5Ez4E2/MkJPmAL8TUo4cQs66upJGhm+UzZ495Cxi57Npk5NUK54Gbx5Fh+d0NvJRtuTUCWDyurn0eT4E/THmNgBjvIA9JpcW69yfwV6/SZv/PNXIsjGT5Tcg01g+UoHnvevVvWuF24I3d/yGqHdCsxyq8IgEURuAJ+CnDg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013572; c=relaxed/simple;
	bh=HnGE5lrb+ed+jZVNTRGh9kbSwPoRyH8eoBWAR6n0moM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkYLuHmT54C0x6fT/yJbh7ivIYCrkBYpvv/b3kMQpJ12Oz9l4045viSd9cxYDHLF8lsXrcKrgI4VuQz1yQkxRIJjixp9ioYsK6PfwnHmUODzgVAtq2KNiSESdUHBk4F8LIPmRKfYrULueSpNtbwGpG0GAheo35pUqW98jLaU8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ef2qCtNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB61BC433C7;
	Thu, 21 Mar 2024 09:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711013572;
	bh=HnGE5lrb+ed+jZVNTRGh9kbSwPoRyH8eoBWAR6n0moM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ef2qCtNUiLY5ebRSyaw0H+w+ZXaMgp3IUWZFer4qwYu/3peKtoZpv9InBU6ySkkxY
	 YAE0XpR7/8VyDGm9E9Xp1BiUcJP7dmdYTcrPP+IU+HvUnbjLkxbJXRrui/ICgpblLA
	 G10PHw0wXoK6LjBtCccO1vgGF2NQXo6qiEJxyvZZW5eLzgb3fAgsYCyAvlDI6wwBaa
	 B/d7Sxtrm1lw0OTyXzgc2bF7hdKA59oxIZxbEKILP+Sc4bQJY1AILySVUSiZAWoj29
	 REeylqFjse5KBSDJLj+QcMzj4OcThjg+2EZxQwOHt6imNVjwUd6GvIMc9Mmktep6vI
	 XZnL/y7c/jbzg==
Date: Thu, 21 Mar 2024 11:32:48 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net
Subject: Re: [PATCH] [PATCH ipsec] xfrm: Store ipsec interface index
Message-ID: <20240321093248.GC14887@unreal>
References: <20240318231328.2086239-1-wangfe@google.com>
 <20240319084235.GA12080@unreal>
 <CADsK2K_65Wytnr5y+5Biw=ebtb-+hO=K7hxhSNJd6X+q9nAieg@mail.gmail.com>
 <ZfpnCIv+8eYd7CpO@gauss3.secunet.de>
 <CADsK2K-WFG2+2NQ08xBq89ty-G-xcoV517Eq5D7kNePcT4z0MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADsK2K-WFG2+2NQ08xBq89ty-G-xcoV517Eq5D7kNePcT4z0MQ@mail.gmail.com>

On Wed, Mar 20, 2024 at 11:05:13AM -0700, Feng Wang wrote:
> Hi Steffen,
> 
> Thanks for your comment.  Firstly,  the patch is using the xfrm interface
> ID instead of network interface ID. Secondly, would you please point me to
> the 'packet offload drivers' in the kernel tree?

First, please don't reply to emails in top-post format.
Second, did you try to search for "packet offload drivers" in the kernel?
https://elixir.bootlin.com/linux/v6.8.1/source/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c#L1152

Thanks

> I want to understand how the offload driver can distinguish 2 ipsec
> sessions if two sessions accidentally have the same address/mask and proto
> values(same xfrm_selector)? The offload driver needs to find the
> corresponding encryption parameters to do the work.
> 
> Thank you for your help,
> 
> Feng
> 
> 
> 
> On Tue, Mar 19, 2024 at 9:33 PM Steffen Klassert <
> steffen.klassert@secunet.com> wrote:
> 
> > On Tue, Mar 19, 2024 at 10:15:13AM -0700, Feng Wang wrote:
> > > Hi Leon,
> > >
> > > There is no "packet offload driver" in the current kernel tree.  The
> > packet
> > > offload driver mostly is vendor specific, it implements hardware packet
> > > offload.
> >
> > There are 'packet offload drivers' in the kernel, that's why we
> > support this kind of offload. We don't add code for proprietary
> > drivers.
> >
> > > On Tue, Mar 19, 2024 at 1:42 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > > On Mon, Mar 18, 2024 at 04:13:28PM -0700, Feng Wang wrote:
> > > > > From: wangfe <wangfe@google.com>
> > > > >
> > > > > When there are multiple ipsec sessions, packet offload driver
> > > > > can use the index to distinguish the packets from the different
> > > > > sessions even though xfrm_selector are same.
> > > >
> > > > Do we have such "packet offload driver" in the kernel tree?
> > > >
> > > > Thanks
> > > >
> > > > > Thus each packet is handled corresponding to its session parameter.
> > > > >
> > > > > Signed-off-by: wangfe <wangfe@google.com>
> > > > > ---
> > > > >  net/xfrm/xfrm_interface_core.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/xfrm/xfrm_interface_core.c
> > > > b/net/xfrm/xfrm_interface_core.c
> > > > > index 21d50d75c260..996571af53e5 100644
> > > > > --- a/net/xfrm/xfrm_interface_core.c
> > > > > +++ b/net/xfrm/xfrm_interface_core.c
> > > > > @@ -506,7 +506,9 @@ xfrmi_xmit2(struct sk_buff *skb, struct
> > net_device
> > > > *dev, struct flowi *fl)
> > > > >       xfrmi_scrub_packet(skb, !net_eq(xi->net, dev_net(dev)));
> > > > >       skb_dst_set(skb, dst);
> > > > >       skb->dev = tdev;
> > > > > -
> > > > > +#ifdef CONFIG_XFRM_OFFLOAD
> > > > > +     skb->skb_iif = if_id;
> > > > > +#endif
> >
> > This looks wrong. The network interface ID is not the same as the xfrm
> > interface ID.
> >

