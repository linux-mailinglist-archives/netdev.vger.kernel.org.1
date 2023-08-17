Return-Path: <netdev+bounces-28511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E3F77FA7B
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72131C2122F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD5B15481;
	Thu, 17 Aug 2023 15:14:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D613FF1;
	Thu, 17 Aug 2023 15:14:48 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A93D2D74;
	Thu, 17 Aug 2023 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+IFPX83lPaAOGdnhnP/eIMxERGqSGxvY5B0ikm9lkO0=; b=2w9misJitUSHvle93U8BZqSrbP
	9clMJJvZImdBdayMGB06Nhk5YYHLNh37NSV8kJxI5/4m4bdJEEDvYGgswEAmDo+CxBGxM1ikKG4nk
	kL5u4nSoEpzoMAqI9xLLAz6F/UV4oG0eCDuUPfMdG8vQ9Tn7YTMrP2AxYunh1sTV9QIk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWehb-004OhF-LW; Thu, 17 Aug 2023 17:14:23 +0200
Date: Thu, 17 Aug 2023 17:14:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michele Dalle Rive <dallerivemichele@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Davide Rovelli <davide.rovelli@usi.ch>,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
Message-ID: <9cb6cb27-bcde-46a1-a7ec-fb251c64fb67@lunn.ch>
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
 <2023081411-apache-tubeless-7bb3@gregkh>
 <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
 <CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com>
 <e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch>
 <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> I am wondering whether the `net` subsystem is interested in reviewing, giving
> feedback and eventually accepting code that is currently OOT-only.

netdev, and the linux kernel in general, has no interest in code to
support out of tree modules. It adds maintenance cost for no gain.
 
> Also, it would be interesting if you could provide us any module or
> functionality you are planning to get in-tree which might use this interface;
> it could be useful in order to understand the applicability of these
> abstractions and find a concrete in-kernel use-case.

You need real code which does something useful for the community. Your
problem is, there is little use of sockets inside the kernel. I did
list a few examples in my first reply. Network file systems, logging
kernel messages to a remote server. I thought of one more afterwards,
there is dhcp client code used for NFS root, which could make use of
raw sockets.

However, you have the problem you cannot just rewrite this existing
code in Rust because it is core code and needs to work on all
architectures. And my understanding is, there are currently not Rust
compilers for all architectures.

What you can however do is implement something new, which the kernel
does not have. If it never existed, it is hard to complain it is only
available for a restricted number of architectures. So maybe look
through the RFCs and IETF documents and see if you can find something
which is both useful, and makes sense to be implemented in the kernel.

      Andrew

