Return-Path: <netdev+bounces-216912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25560B35F5C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D09462AD4
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59151319867;
	Tue, 26 Aug 2025 12:43:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881C29D280;
	Tue, 26 Aug 2025 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212196; cv=none; b=V5VmqBI+mPBOlKsttVqKFMKVSXXovFu1yIZwluZ/1iAt4R/js22zY7PtnIf6EvQZ2rw3ZLC3Yo6FHjgo9/KKmVrNqJwaWVRi3s/6+Q41Pa5u+kq029fyfRtnoo7HdseXdrPpgl66dJrv6hjPVDgnMJ/0kfDDdoONyFJWJ0HvKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212196; c=relaxed/simple;
	bh=E3lKJnXF6k/flLtgtrzdPU4k0vJ7hdH3EtlPDfTiZbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcJ5JHXz+8JkDZtnww7tyUO8UQg20iveQ1j4T49025Lmy17hQTxWODPNmvtcg32a9yhUqJeu2OXFakIND6UcrQzyRPx4z4j1sB0mpGEk0fHp5Wy5hppk3JLVG+M3PEBWD37hfUm2ILN2aS7BBfzqWF7rVj49c9Vw/SwbQYnc+fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61a8c134609so6924785a12.3;
        Tue, 26 Aug 2025 05:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212193; x=1756816993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A45A8CgqJyJGta/ZNHLL6IXg2WGgk+TeIJYni0Vt7SU=;
        b=D7FnULOySfqzzQ9Ua749XDGWrDgx9McwmBokreUqzQlLeo/uX4gOdomA3LeAwv7VHC
         pIvGEgzT3LBZEbabhs/cte6+MA56wsey+sAJ0qhhgSNVl7r6TrLr90C8IOVH1rcPsMdl
         ujlMcnSrI8qUmbB9Z4YFnMIMxZHAwkfWwszRBoKJv/sST+GCKR+0IUoxvOScYqcpxGkh
         88oOac0UEVIE/Kl7TepbTetfS9vHS1yeeBhxYcTYIbmhB2aVaRJM2rmRItuVy9EImT1N
         hlX+ZC3BP6wI1ueidYcRTVnEb05Ncw+7w96kc6JafCvECnraSwe4a6SXE4V9V3XOy5je
         l7jg==
X-Forwarded-Encrypted: i=1; AJvYcCWIDJAIo8eG93wDruvmBoOkYfPNuvP5gIeVM4MVQ2TSguchO0zgFgr+SdpC1IL3SFTTK4OyCoNG@vger.kernel.org, AJvYcCXlUpNu2Jjps437kDMPtybR9lm19/2j8BW8atNI5tbtl65HcmAGOLBgyd6cj3hXN+BVcQJtNu3DyYlJDbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFhB90INuIbB4l8RzxV18NBcf13FXDQV9X90ZfxakMrT4ndOWp
	TDKulFSStOcROdvCbJ5OOL257DesrHLM6FJjtRIJmAuTvrZBQu/Cfl4a
X-Gm-Gg: ASbGncuA/kd+9ni8QBvmceTCnsQ306s6/FF8Yl+yj17Wfg1To+YFCqXJ39eAtdfjR57
	U85VcOuX6WgLCAAGGxfohx0xD+owVsmhzva16KQFSFXFNKMb8lxOVo4kB/3h3NaqKqakv3erqqb
	l7CFl0WYL8B/G5QkHUPZmarIEWd+b4gGPSLiNve+I8s+E2+d7kWUhuXTVUIbUujMSIQZChwiAbL
	hJMH5WKfvQawSXaYouFUCaMPEa93nelK+PfHZoA/9n62QrAzge9wT+NVbGND6eslqjFr/EGXvyp
	NUaVjCyPZktru0VKWIIi0vuAIZ0U0F6MNU9uODqT3XVG38I1x8FeMCY1AkG4er4s7gMoIso3/Td
	UXE4Oz/wpxbvDhJ/O4UY07O4=
X-Google-Smtp-Source: AGHT+IEDfTrnQUo/uJH1qHMiXflndbp2yyTSPamaEijw/d90zSSYm9XSewqG8TmDTPZ7ohF0zVLrFQ==
X-Received: by 2002:a05:6402:5189:b0:61c:5379:4265 with SMTP id 4fb4d7f45d1cf-61c53794504mr6343160a12.1.1756212192514;
        Tue, 26 Aug 2025 05:43:12 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3119f85esm6750725a12.10.2025.08.26.05.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:43:11 -0700 (PDT)
Date: Tue, 26 Aug 2025 05:43:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Mike Galbraith <efault@gmx.de>, Simon Horman <horms@kernel.org>, 
	kuba@kernel.org, calvin@wbinvd.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, paulmck@kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
References: <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>

On Fri, Aug 22, 2025 at 05:54:28AM +0200, Mike Galbraith wrote:
> On Thu, 2025-08-21 at 10:35 -0700, Breno Leitao wrote:
> > > On Thu, Aug 21, 2025 at 05:51:59AM +0200, Mike Galbraith wrote:
>  
> > > > > --- a/drivers/net/netconsole.c
> > > > > +++ b/drivers/net/netconsole.c
> > > > > @@ -1952,12 +1952,12 @@ static void netcon_write_thread(struct c
> > > > >  static void netconsole_device_lock(struct console *con, unsigned long *flags)
> > > > >  {
> > > > >  	/* protects all the targets at the same time */
> > > > > -	spin_lock_irqsave(&target_list_lock, *flags);
> > > > > +	spin_lock(&target_list_lock);
> > > 
> > > I personally think this target_list_lock can be moved to an RCU lock.
> > > 
> > > If that is doable, then we probably make netconsole_device_lock()
> > > to a simple `rcu_read_lock()`, which would solve this problem as well.
> 
> The bigger issue for the nbcon patch would seem to be the seemingly
> required .write_atomic leading to landing here with disabled IRQs.

In this case, instead of transmitting through netpoll directly in the
.write_atomic context, we could queue the messages for later delivery.

With the current implementation, this is not straightforward unless we
introduce an additional message copy at the start of .write_atomic.

This is where the interface between netpoll and netconsole becomes
problematic. Ideally, we would avoid carrying extra data into netconsole
and instead copy the message into an SKB and queue the SKB for
transmission.

The core issue is that netpoll and netconsole are tightly coupled, and
several pieces of functionality that live in netpoll really belong in
netconsole. A good example is the SKB pool: that’s a netconsole concept,
not a netpoll one. None of the other netpoll users send raw char *
messages. They all work directly with skbs, so, in order to achieve it,
we need to move the concept of skb pool into netconsole, and give
netconsole the management of the skb pool.

> WRT my patch, seeing a hard RT crash on wired box cleanly logged with
> your nbcon patch applied (plus my twiddle mentioned earlier) tells me
> my patch has lost its original reason to exist.  It's relevant to this
> thread only in that those once thought to be RT specific IRQ disable
> spots turned out to actually be RT agnostic wireless sore spots.

Thanks. As a follow-up, I would suggest the following steps:

1) Decouple the SKB pool from netpoll and move it into netconsole

  * This makes netconsole behave like any other netpoll user,
    interacting with netpoll by sending SKBs.
	* The SKB population logic would then reside in netconsole, where it
	  logically belongs.

  * Enable NBCONS in netconsole, guarded by NETCONSOLE_NBCON
	* In normal .write_atomic() mode, messages should be queued in
	  a workqueue.
	* If oops_in_progress is set, we bypass the queue and
	  transmit the SKB immediately. (Maybe disabling lockdep?!).

Any concern with this plan?
--breno

