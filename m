Return-Path: <netdev+bounces-37571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FB7B60CC
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 08:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7918E2817EC
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 06:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E183D9E;
	Tue,  3 Oct 2023 06:31:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296628E2;
	Tue,  3 Oct 2023 06:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CB2C433C8;
	Tue,  3 Oct 2023 06:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696314701;
	bh=adS6IEqFZxln5xGsqrx2IJIePi71pek0Pzz0aUk+75A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWFupqZlV6gND8KRIbruuNXdjpWSjCIodNbodja1hh1VmJb8dOwm3Ghd4aW2TB2HG
	 sV9N1BqaZW8oMhkS1MRZQBi1z3au/rlz2trv2cZEIgm41d1rGKEWiYUISNgZRNbxud
	 w/B6f45Owz6LJxS9QH5vDlqylmrbLjNdWn2QtElw=
Date: Tue, 3 Oct 2023 08:31:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v1 1/3] rust: core abstractions for network PHY drivers
Message-ID: <2023100317-glory-unbounded-af5c@gregkh>
References: <ec65611a-d52a-459a-af60-6a0b441b0999@lunn.ch>
 <20231003.093338.913889246531201639.fujita.tomonori@gmail.com>
 <9efcbc51-f91d-4468-b7f3-9ded93786edb@lunn.ch>
 <20231003.124311.1007471622916115559.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003.124311.1007471622916115559.fujita.tomonori@gmail.com>

On Tue, Oct 03, 2023 at 12:43:11PM +0900, FUJITA Tomonori wrote:
> On Tue, 3 Oct 2023 03:40:50 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > On Tue, Oct 03, 2023 at 09:33:38AM +0900, FUJITA Tomonori wrote:
> >> On Mon, 2 Oct 2023 16:52:45 +0200
> >> Andrew Lunn <andrew@lunn.ch> wrote:
> >> 
> >> >> +//! Networking.
> >> >> +
> >> >> +#[cfg(CONFIG_PHYLIB)]
> >> > 
> >> > I brought this up on the rust for linux list, but did not get a answer
> >> > which convinced me.
> >> 
> >> Sorry, I overlooked that discussion.
> >> 
> >> 
> >> > Have you tried building this with PHYLIB as a kernel module? 
> >> 
> >> I've just tried and failed to build due to linker errors.
> >> 
> >> 
> >> > My understanding is that at the moment, this binding code is always
> >> > built in. So you somehow need to force phylib core to also be builtin.
> >> 
> >> Right. It means if you add Rust bindings for a subsystem, the
> >> subsystem must be builtin, cannot be a module. I'm not sure if it's
> >> acceptable.
> >  
> > You just need Kconfig in the Rust code to indicate it depends on
> > PHYLIB. Kconfig should then remove the option to build the phylib core
> > as a module. And that is acceptable.  
> 
> The following works. If you set the phylib as a module, the rust
> option isn't available.

That does not seem wise.  Why not make the binding a module as well?

thanks,

greg k-h

