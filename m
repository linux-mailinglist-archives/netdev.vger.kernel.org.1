Return-Path: <netdev+bounces-283545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGcsF2Dm9mlhZgIAu9opvQ
	(envelope-from <netdev+bounces-283545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:08:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A9B4B4906
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EC8F30000A5
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 06:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65503A63EB;
	Sun,  3 May 2026 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qk7VuwsP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B476A20E023;
	Sun,  3 May 2026 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777788505; cv=none; b=BwNuY/B1AlHJiH3bptvdPWPeKrXG/BsRuAdOPTAZXGX+s+CGhsK9KzdErTaoIUcMu3B4m/N+yNhxbDkwFIOzhjGMG2tGOsI9giMsMayXW1Ey+cckJqAhCtNOYnCGohVd9sWdjHaxmSCX6A/mDPpvWNiwR3X2qHNVAzB/KidF0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777788505; c=relaxed/simple;
	bh=wVjTwrEj04/03byuBlM0H1sdjlFRqIutG2Iz7Ehjs3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGpxjkGrUHBkLANnVavnB8SYlOLBv8oyAZu3u2GoKZDFil0GPzV6xUpmsu9hsPOBWcqkRj3JtxSDaUWQfIhczzwP12dAKA8yBSSRU466kAUjtPSqaAhUSFYTdWnVJAFn0iD+M5xnLJyjmbBF9ZwFJVy9lKZ2RC+ze83VaNsqnSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qk7VuwsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB33DC2BCB4;
	Sun,  3 May 2026 06:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777788505;
	bh=wVjTwrEj04/03byuBlM0H1sdjlFRqIutG2Iz7Ehjs3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qk7VuwsPlzs4FONxH6v1uneq3DAWLmsc1aXoxocuGrQTt1xSkryaYzVZaEXe8kcL2
	 owwUqmsOaPLYnY8zX/DLSOGslkeqkKgFAV1uOCP9ZkUcqz9ukxPKQ8vZ86XHg8dzWE
	 7p8C3CUkKd2MZYtIm+7vnFrGpPe4n9h2H5Y2DDW0=
Date: Sun, 3 May 2026 08:08:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org,
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
Message-ID: <2026050316-plant-spool-14c6@gregkh>
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
X-Rspamd-Queue-Id: 06A9B4B4906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283545-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lwn.net,linuxfoundation.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,garyguo.net,protonmail.com,umich.edu,linux.dev];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, May 02, 2026 at 11:00:53PM -0700, Ethan Nelson-Moore wrote:
> Hi, Greg,
> 
> On Sat, May 2, 2026 at 10:44 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Then that means someone uses it somewhere.  Don't generate bindings for
> > something that will break because it is no longer in the tree :(
> That project generates bindings for every UAPI header automatically,
> but has a hardcoded lost of them, so its presence there doesn't mean
> anyone is using it.
> 
> > If no one does use it, then please get that project to fix their code so
> > that we don't break their build.
> They have had to remove headers from their list that got removed from
> the kernel before. I will send them a pull request to remove this
> header and then resend this patch with the UAPI header removal
> restored. Does that sound good to you?

Yes, thanks.


