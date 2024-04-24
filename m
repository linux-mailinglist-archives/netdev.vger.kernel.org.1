Return-Path: <netdev+bounces-90995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2308B0DAB
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98398287D6E
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FB915EFC7;
	Wed, 24 Apr 2024 15:11:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C21615ECFA
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971493; cv=none; b=nryvpeiFDCLLWwsrd9U3f71NkMRsGrmtMZC+kPHTiQAVi9R7Sx6sNsub3EFAElyhC4I11z4Ohp/T6a9E6kc+5YF/5vmGnkbjVl/D1bIKG+RQCC6W6qIlfUj1JpGSS4iOu4xs0ULf/F+kbuLT6l+JbHYrSQHhUXEM1er6DhuPnCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971493; c=relaxed/simple;
	bh=OKKb+pfBgAU61YybSZOCS7udQ+HT6CBZB9qU9W/+7es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQdQKliZ8+2tme0hDJeVKbObqxJzZf119S/5V2yH1iYxnT3i56nh1mQ0sqsnAxZmjVsQz4JArId4Jz7iTKKVkgaFzfPz1xJV/C561uuk5ecem1RS9P2EdHZ6qGnNC0LAw/BtfWHWoRPcwdlUy0lhbnuyCevL0i4yM2v1X29cVSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso60155461fa.1
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 08:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971490; x=1714576290;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKmoi/367OwWIF7YrC0db5/eqzsRVsB9TZPuJIPDJpE=;
        b=lBJW3/tvEiuZkNJNiSNUQzmfzA5toc7CUmjY8hwH6fcD45GlKe+rFGGNFc6qj7jh6R
         b8X9JkGsktYyra0K+D0GbJrxlqmpFNt4wdE/hmzgZ8vz8vD8r4lfkKqL9TiWK2WNT0bB
         ExWlqUaDi/HZnBzvs9yltL/zsbteqx/S56bvQ/FNqEwtpynKCj8xYj41KNgHdVT6h+RD
         gK8QANWdE1uSIt7wr3YpmAqEBQCS9a5jgVLXyOFZdRqj5PipGwelmBA5QiFrQiprAn21
         tuz0bfcbbC+RLUDpnTrKJugqN6GJcHlPdvhoWJBV47zRSNIP4qYmOqIWibu0XI3we42L
         PuXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYyIfRjYj4RWYtjVTagi6lafawJrTLbZYflpHusPTyuNsIAvv+1r5p7Po+P1j3oUva0Ephn7LCM4m0Ak9KyMcDP9gS1tmt
X-Gm-Message-State: AOJu0YyWDZC88i1rn1plXhhNfO+MQfAOgSbj5CLtsb2trStOXc/zjM1b
	Yg5WrhGQ444efTfVDUs2/R43mCxwkGHqtOrnA9fc0w0/6b8BRxA8
X-Google-Smtp-Source: AGHT+IE6/5OeWFg4RHp/i3pxHlXKzv4HHIQpsnqvngttRudVw8/ZUSEj7L1o5cpFt7E4UmkqKOcNkw==
X-Received: by 2002:a2e:3a0f:0:b0:2de:22b2:ab3d with SMTP id h15-20020a2e3a0f000000b002de22b2ab3dmr2416276lja.7.1713971489936;
        Wed, 24 Apr 2024 08:11:29 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id c27-20020a170906d19b00b00a5557bc8920sm8460035ejz.54.2024.04.24.08.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 08:11:29 -0700 (PDT)
Date: Wed, 24 Apr 2024 08:11:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next] ip6_vti: fix memleak on netns dismantle
Message-ID: <ZikhH7gY/cvGaVJO@gmail.com>
References: <20240415122346.26503-1-fw@strlen.de>
 <ZieDYD5ibpGjlIRw@gmail.com>
 <CANn89iJQZd8EPv+uXp4=+fbp4gMxa9d2CDdqmE3LwXV9makaZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJQZd8EPv+uXp4=+fbp4gMxa9d2CDdqmE3LwXV9makaZg@mail.gmail.com>

Hello Eric,

On Tue, Apr 23, 2024 at 09:53:45PM +0200, Eric Dumazet wrote:
> On Tue, Apr 23, 2024 at 11:46 AM Breno Leitao <leitao@debian.org> wrote:
> >
> > Hello Florian,
> >
> > On Mon, Apr 15, 2024 at 02:23:44PM +0200, Florian Westphal wrote:
> > > kmemleak reports net_device resources are no longer released, restore
> > > needs_free_netdev toggle.  Sample backtrace:
> > >
> > > unreferenced object 0xffff88810874f000 (size 4096): [..]
> > >     [<00000000a2b8af8b>] __kmalloc_node+0x209/0x290
> > >     [<0000000040b0a1a9>] alloc_netdev_mqs+0x58/0x470
> > >     [<00000000b4be1e78>] vti6_init_net+0x94/0x230
> > >     [<000000008830c1ea>] ops_init+0x32/0xc0
> > >     [<000000006a26fa8f>] setup_net+0x134/0x2e0
> > > [..]
> > >
> > > Cc: Breno Leitao <leitao@debian.org>
> > > Fixes: a9b2d55a8f1e ("ip6_vti: Do not use custom stat allocator")
> > > Signed-off-by: Florian Westphal <fw@strlen.de>
> > > ---
> > >  net/ipv6/ip6_vti.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> > > index 4d68a0777b0c..78344cf3867e 100644
> > > --- a/net/ipv6/ip6_vti.c
> > > +++ b/net/ipv6/ip6_vti.c
> > > @@ -901,6 +901,7 @@ static void vti6_dev_setup(struct net_device *dev)
> > >  {
> > >       dev->netdev_ops = &vti6_netdev_ops;
> > >       dev->header_ops = &ip_tunnel_header_ops;
> > > +     dev->needs_free_netdev = true;
> >
> > Thanks for the fix!
> >
> > Could you help me to understand how needs_free_netdev will trigger the
> > free()here?
> >
> > I _though_ that any device that is being unregistered would have the stats
> > freed.
> >
> > This is the flow I am reading:
> >
> > 1) When the device is unregistered, then it is marked as todo:
> >
> >         unregister_netdevice_many_notify() {
> >                 list_for_each_entry(dev, head, unreg_list) {
> >                         net_set_todo(dev);
> >                 }
> >         }
> >
> > 2) Then, "run_todo" will run later, and it does:
> >         netdev_run_todo() {
> >                 list_for_each_entry_safe(dev, tmp, &list, todo_list) {
> >                 if (unlikely(dev->reg_state != NETREG_UNREGISTERING)) {
> >                         netdev_WARN(dev, "run_todo but not unregistering\n");
> >                         list_del(&dev->todo_list);
> >                         continue;
> >                 }
> >
> >                 while (!list_empty(&list)) {
> >                         netdev_do_free_pcpu_stats(dev);
> 
> The relevant part is missing:
> 
>                          if (dev->needs_free_netdev)
>                                   free_netdev(dev);
> 
> >                 }
> >
> >         }
> >
> > Thank you!
> 
> I do not think Florian patch has anything to do with free_pcpu_stats()

That makes total sense now.

I though the memory that was being leaked was related to pcpu stats,
since this is was I was supposedly changing, but, it is not.

The regression is not related to the fact that 
a9b2d55a8f1e ("ip6_vti: Do not use custom stat allocator") removed
the following line wrongly:

	-dev->needs_free_netdev = true;

Everything is clear now.
Thanks!

