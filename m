Return-Path: <netdev+bounces-44776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840B87D9B51
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 16:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE3528236A
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3801A5A3;
	Fri, 27 Oct 2023 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K/mlniQo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFC13FF5;
	Fri, 27 Oct 2023 14:26:27 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02332187;
	Fri, 27 Oct 2023 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hekSSprq4jGUgYm6GeOL17z6wq6xiPTdJAuxe1N8hTU=; b=K/mlniQopKP5dReS0joMOqiYpi
	/4JfzuH7WuCvkfGed2u6iEs2tLMq3zi9XjUinegwLjGqKvAdUzKrk4wF3dp0q9TUFXttTvlj49oFp
	4sBY5usauIcSmfzeF9BAsjpua6l1ifK3ECJCiwvo2nc/5vRjM7GyIZBqqVJB00JYU9aY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwNn4-000LTZ-53; Fri, 27 Oct 2023 16:26:22 +0200
Date: Fri, 27 Oct 2023 16:26:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
Message-ID: <a378ced1-71f1-46f7-bbba-b5aacb9a66a6@lunn.ch>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>
 <ZTsbG7JMzBwcYzhy@Boquns-Mac-mini.home>
 <c40722eb-e78a-467d-8f91-ef9e8afe736d@lunn.ch>
 <ZTsqROr8s18aWwSY@boqun-archlinux>
 <ZTs73ZBgGZ-oHwF4@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTs73ZBgGZ-oHwF4@boqun-archlinux>

On Thu, Oct 26, 2023 at 09:26:05PM -0700, Boqun Feng wrote:
> On Thu, Oct 26, 2023 at 08:11:00PM -0700, Boqun Feng wrote:
> [...]
> > > likely will be merged. Real problems can be fixed up later, if need
> > > be.
> > 
> > But this doesn't apply to pure API, right? So if some one post a pure
> > Rust API with no user, but some tests, and the CI passes, the API won't
> > get merged? Even though no review is fine and if API has problems, we
> > can fix it later?
> > 
> 
> I brought this up because (at least) at this stage one of the focus
> areas of Rust is: how to wrap C structs and functions into a sound and
> reasonable API. So it's ideal if we can see more API proposals.
> 
> As you may already see in the reviews of this patchset, a lot of effort
> was spent on reviewing the API based on its designed semantics (rather
> than its usage in the last patch). This is the extra effort of using
> Rust. Is it worth? I don't know, the experiment will answer that in the
> end ;-) But at least having an API design with a clear semantics and
> some future guards is great.
> 
> The review because of this may take longer time than C code, so if we
> really want to keep up with netdev speed, maybe we relax the
> must-have-in-tree-user rule, so that we can review API design and
> soundness in our pace.

The rule about having a user is there for a few reasons:

Without seeing the user, you cannot say if the API makes sense.  How
is the user using the API? Is the architecture of the user correct?
Fixing the architecture of the user could change the API. As an
example, i've seen Rust wrapper on top of sockets. The read/write
method use a plain block of memory. However, for a network filesystem,
what you actually need to send is probably represented by a folio of
pages in the buffer cache. Its more efficient to hand the folio over
to the network stack. If the data is coming from user space, its
probably coming via a socket. So its probably in the form of a list of
chunks of data, maybe still in userspace, maybe with a header added in
kernel space. You want to pass that representation to the stack, which
can already handle it in an optimal way. A plain block of memory could
in fact be correct, there are use cases where its simple command being
sent to a modem. But its impossible to say what is correct unless you
can use the user.

Another point is that internal API are unstable. Any developer can
change any API anywhere in the kernel, if they can justify it. That is
an important feature of the kernel, and we don't like making it harder
to change APIs. If you cannot see both sides of an API, its hard to
know if you can change it, or how you need to change it. And at the
moment, there are very few Rust developers. An API in Rust is going to
be harder for a developer to change. So we have a strong reason to
keep Rust APIs minimal, with clear users.

But this API unstableness plays both ways. You don't need a perfect
API before it is merged. You just need it good enough. You can keep
working on it once its merged. If you missed something which makes is
unsound, not a problem, its just a bug, fix it an move on, like any
other bug.

	Andrew    




