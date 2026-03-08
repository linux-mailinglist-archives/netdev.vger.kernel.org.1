Return-Path: <netdev+bounces-265308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Wh3qFmCMrWkl4QEAu9opvQ
	(envelope-from <netdev+bounces-265308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 15:49:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990F8230BD2
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 15:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 517F0300F9DE
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9D81DE8BE;
	Sun,  8 Mar 2026 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B/LqFbQe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FC516FF37;
	Sun,  8 Mar 2026 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772981339; cv=none; b=Nl6Mol6cUIzO5rDAhBMvpXvkXZkNKVJMbLHq/i/Oci14Ho47maJdeV4k4Qv3R0TPdIG/fjteZaRNjtOyul5S0xxZDKoDC8fyyL+z7zNZxM3o5LXQuBOtixvYeRnSrSQXgW3L2kF/KifCrDACEvCGTKlpsueAWAojbvOqqDISqJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772981339; c=relaxed/simple;
	bh=HLIezFGjthTiazzaQbHers6OpMSLq2BXvtIHV2couLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4bFQDkFR8SJzsCwmn/Wtg7gkjg6XzCBRSTfmlkCZq5mCdblbQjpjqV0WIY46VkcTSJLq7fFvmWnApJGbNLhibNf2EfLKM05he+ppZvXzqANwdXLklPpDpZfC5Ibh79UHNP3YeJQ8ChYoVicUFsuU2IeZUtsf2PMpQWBpRsiJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B/LqFbQe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NoufFNuXq8Byu4dS79mqi0hwD0Fo6SoBh2B9SVZGGoY=; b=B/LqFbQeT04a4EPag8mSo8lmse
	H+6vjj67wKDrAquwPoKem58ibERr7Ox16dzIc7wD2oRSyex3GVzrhQy1Xo++7TRI02GWiuj6wfghV
	g0+8d/nKzdnzNU+7JR5B1Xkpm5YBRGjVZ1GgCvJRGHbNp2F0t5WGxgjKuAfudB7g1ViM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vzFQu-00Air6-UD; Sun, 08 Mar 2026 15:48:40 +0100
Date: Sun, 8 Mar 2026 15:48:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] rust: netlink: add raw netlink abstraction
Message-ID: <f93ee07b-5dfd-4748-a7f2-814539e60d81@lunn.ch>
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <20260306-binder-netlink-v1-1-daceb5bc83f2@google.com>
 <081b1f16-5c8b-4a18-a9f1-d56e757de4c0@lunn.ch>
 <aayYhgy3pRxFWbr7@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aayYhgy3pRxFWbr7@google.com>
X-Rspamd-Queue-Id: 990F8230BD2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265308-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netlink.rs:url,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Action: no action

> We can make a kernel::net module (rust/kernel/net/) and put it there
> instead? I guess netlink.rs can also be a submodule of that.
> 
> Hmm ... but I'm currently using genlmsg_new() / nlmsg_free(), and I
> assume the other use-cases do not go through those methods, since they
> sound netlink specific.
> 
> To be honest, I'm new to the kernel's networking stack, so I probably
> can't design Rust wrapper for sk_buff that supports all those different
> usecases without someone walking me through how it works. It may or may
> not be best to write a netlink-specific struct now and expand it later.

At its core, an skbuff represents a block of memory. Normally that
memory would be packet data flowing through the network stack. You can
append to the front and back of the data in the buffer. You can add
the buffer to linked lists, there are reference counting operations,
so the buffer can have multiple users, there are places you can store
per protocol data, and places you can store data while within one
protocol layer, etc.

When using sk_buff for packet data, you are generally on a fast path,
so much of the code is in header files as inline functions. This is
going to make rust binding harder, my current understanding is that it
is hard to make use of such functions from rust.

However, for netlink, its is slow path code, it seems like all the
functions you need to call are in object files, not inline headers.

I also suspect, but don't know, that the netlink upper API is disjoint
to the packet handling upper API. How you allocate a skbuff for
netlink is different to packet data. It is very likely an error if you
try to transmit out an interface an skbuff allocated for netlink
usage, etc.

So, maybe you can have a base definition of skbuff in rust/kernel/net,
and build on top of that to make a netlink specific skbuff, with a
limited list of methods which can access it, those needed for netlink?
Make use of the Rust type system? And leave the messy fast path packet
data things for somebody else.

     Andrew

