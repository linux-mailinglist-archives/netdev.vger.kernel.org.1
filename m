Return-Path: <netdev+bounces-16580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E7774DE9E
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C642812E6
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D99B14ABE;
	Mon, 10 Jul 2023 19:53:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76CE15483
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 19:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B84C433C7;
	Mon, 10 Jul 2023 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689018807;
	bh=ZQLAF664MoAnYtWv5E94iquWvL1fzy2b4GZ39N1JM14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vSfYDTyOeLyG6wmRZyhz0363UM42HyCAKFCugyNOAtFbVi56rYsxwVRluRMK7HSYP
	 QUlJCrzadBIsrFoV1ssJhfPNwKtKCipZjv61veSJh4yfS80AA8pngcIC+UuqUp+4VY
	 WQLV8HD9jaH7Sk9f+TDlAoeEAYxSho182GVLG+SU=
Date: Mon, 10 Jul 2023 21:53:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, aliceryhl@google.com,
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me
Subject: Re: [PATCH v2 0/5] Rust abstractions for network device drivers
Message-ID: <2023071049-gigabyte-timing-0673@gregkh>
References: <20230710073703.147351-1-fujita.tomonori@gmail.com>
 <20230710112952.6f3c45dd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710112952.6f3c45dd@kernel.org>

On Mon, Jul 10, 2023 at 11:29:52AM -0700, Jakub Kicinski wrote:
> On Mon, 10 Jul 2023 16:36:58 +0900 FUJITA Tomonori wrote:
> > This patchset adds minimum Rust abstractions for network device
> > drivers and an example of a Rust network device driver, a simpler
> > version of drivers/net/dummy.c.
> > 
> > The major change is a way to drop an skb (1/5 patch); a driver needs
> > to explicitly call a function to drop a skb. The code to let a skb
> > go out of scope can't be compiled.
> > 
> > I dropped get_stats64 support patch that the current sample driver
> > doesn't use. Instead I added a patch to update the NETWORKING DRIVERS
> > entry in MAINTAINERS.
> 
> I'd like to double down on my suggestion to try to implement a real
> PHY driver. Most of the bindings in patch 3 will never be used by
> drivers. (Re)implementing a real driver will guide you towards useful
> stuff and real problems.

And I'd recommend that we not take any more bindings without real users,
as there seems to be just a collection of these and it's hard to
actually review them to see how they are used...

thanks,

greg k-h

