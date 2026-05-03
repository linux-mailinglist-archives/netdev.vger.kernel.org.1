Return-Path: <netdev+bounces-283606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDlsEF9a92kNggIAu9opvQ
	(envelope-from <netdev+bounces-283606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 16:23:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F204B6069
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 16:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB2A5300A61F
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29643CCFB4;
	Sun,  3 May 2026 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VAgoZfbN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016B3CCFB0;
	Sun,  3 May 2026 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777818193; cv=none; b=uBE71QslBLfpbfAF9TjjCqDkrZ2tNbPBlY3V7gmzUETrrU3YLwekX/WN1GxiUsZEbSHYhjkX/s+KeO6Fbt1hY9uhU4rUqH4kawtT0rXN/bAyg0KNi2s8ioBNIleYMEOG7RVH3yUg0nV/yExHlYlcEpzGXI32g+sLmRQeP4FS87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777818193; c=relaxed/simple;
	bh=WxZArjg5FoyfLE926199Z7wVkUA9y0L+cYl3TawI+Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdRad6Fk0/faNNz0O9UKrnn+mrXHMM9kdGqUwtGSf9fc5RTQAHuKFsNxycaC8KBsIIoxyCB0FG+VDFzF0u4dvwf3EmFSohnUsb6QaiN6aEu7RkYhBy6IQRXb/7I8mlx/3rS5Qd5Tm5u9ig8mOpFq1Bs1jUw5CD3d8n02JBfKGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VAgoZfbN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=7uvkKz6xcgMrhT7s6scAhh9g4pvpj+Jbi95mAcCpFv4=; b=VA
	goZfbN+x2ysLqv1Sgg0NN2ERvw5cGeBI83OHtBqFPM2doKpa+WpjwWihFkW/bCe05M3/urauiJ2uT
	AH844F0jBjotccOy91+ZuCybtw59Q8NmTy553sF7g3GZiMsMl/UvfHez7Z083GT1z94QP08Ivaj2+
	S28TQise/GNXVj8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJXim-0018UF-71; Sun, 03 May 2026 16:23:00 +0200
Date: Sun, 3 May 2026 16:23:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v2] tty: synclink_gt: remove broken driver
Message-ID: <e12da6e2-5e50-4819-a5a8-2bc675da4c14@lunn.ch>
References: <20260503030801.14080-1-enelsonmoore@gmail.com>
 <2026050340-kilogram-prissy-a833@gregkh>
 <CADkSEUgPtjkKC684O3qB=koKDPwJoUj-qU_4Z_18NAU_+bBqkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUgPtjkKC684O3qB=koKDPwJoUj-qU_4Z_18NAU_+bBqkw@mail.gmail.com>
X-Rspamd-Queue-Id: E0F204B6069
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283606-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,garyguo.net,protonmail.com,umich.edu,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

On Sat, May 02, 2026 at 11:00:53PM -0700, Ethan Nelson-Moore wrote:
> Hi, Greg,
> 
> On Sat, May 2, 2026 at 10:44 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Then that means someone uses it somewhere.  Don't generate bindings for
> > something that will break because it is no longer in the tree :(
> That project generates bindings for every UAPI header automatically,
> but has a hardcoded list of them, so its presence there doesn't mean
> anyone is using it.
> 
> > If no one does use it, then please get that project to fix their code so
> > that we don't break their build.
> They have had to remove headers from their list that got removed from
> the kernel before. I will send them a pull request to remove this
> header and then resend this patch with the UAPI header removal
> restored. Does that sound good to you?

Sounds like a whack a mole problem. I assume the recent removal of ATM
broke it as well? Maybe __has_include() could be used?

      Andrew

