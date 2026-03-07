Return-Path: <netdev+bounces-265197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE/2INOfrGmrrgEAu9opvQ
	(envelope-from <netdev+bounces-265197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:59:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB44122DC84
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7EC330191B1
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193CA346A1F;
	Sat,  7 Mar 2026 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIi/QH82"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C914F9FB;
	Sat,  7 Mar 2026 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772920784; cv=none; b=ESNJ5FJAD9LnXTPNxcQElzXdowAtTeP4WK6BQxGUX7C4H1fbXiGZROxk5Ubb5I2nkUnFwp1LZ3sYVVRsIjWsWeaE2EZ9PEgQnORYZctMLteA54HyoAkTZ5KquUO5nOx0EHA2bL5XtejMriAhCiLOTAwyEGrgCFxZql251hAGj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772920784; c=relaxed/simple;
	bh=vYR50fxKZxiDLmX+pEOc4uv+UC5xHS1Ej0h0VOgf6Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiovD2a+ecBT3yTRfiewek13quQ3KHbHdmwqb5liOFvxzky6ZC87eq45CO0fvidzODoIPunngRxo8104vicLfJStUZTyGU9rKjRnWllp5XK+xs8o2fcxXItvXhCx4YIsKDI3bHUHvcP6ZQ9/skG+zaHRaYMOBIY64VDN4mxBTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIi/QH82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B243C19422;
	Sat,  7 Mar 2026 21:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772920783;
	bh=vYR50fxKZxiDLmX+pEOc4uv+UC5xHS1Ej0h0VOgf6Tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UIi/QH82Rwi+fgVrxBGfbeyUiJLVkcPi4gVI7W1IkWwrHAoCkcoU3gYAQC+xCHaXI
	 1DxslLuHzG8JucFxevAR7xEvcD5f1V83Anz68dKC59EB36AOBiWbLFnCtziyHhWPko
	 eFa4QbVvKmNQHqWCUmwnlTIyoO4NkJhsdFggUyRQI8szLQGs8RokQ3pRKfgW1/TI0X
	 RV9ato+mWdeDCSGlNdmwEL2uKWeGHExOYnVtAk7ZWkOSucbSmSbSEEXquYMQZBQsuF
	 MxGLdqGlgtMKK11BdRBMUkn2LQRoNJ1w/Ru7NQL5hlzhvWUFKVbNiokN7couwaESaK
	 jMDP9OHdUen9g==
Date: Sat, 7 Mar 2026 13:59:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Arve
 =?UTF-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, Carlos Llamas
 <cmllamas@google.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] Rust netlink support + use in Rust Binder
Message-ID: <20260307135941.51353a4f@kernel.org>
In-Reply-To: <aayWSuOM59uojtuG@google.com>
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
	<20260307104131.4c1d0de5@kernel.org>
	<aayWSuOM59uojtuG@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DB44122DC84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265197-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, 7 Mar 2026 21:19:06 +0000 Alice Ryhl wrote:
> On Sat, Mar 07, 2026 at 10:41:31AM -0800, Jakub Kicinski wrote:
> > On Fri, 06 Mar 2026 15:12:12 +0000 Alice Ryhl wrote:  
> > > The C Binder driver exposes messages over netlink when transactions
> > > fail, so that a userpace daemon can respond to processes with many
> > > failing transactions.  
> > 
> > Ugh, now I regret letting binder use Netlink. Should have seen this
> > coming :/  
> 
> To be honest, I'm not entirely happy with what Binder is using netlink
> for either, but it is what it is.

If we're both not happy let's take this opportunity to find a better
solution?

